//
//  NoticeListViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "NoticeListViewController.h"
#import "NoticeViewController.h"

@interface NoticeListViewController ()
{
    UITableView         *_tableView;
    NSMutableArray      *_listArr;

}
@end

@implementation NoticeListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _listArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarWithtitle:@"公告列表" superView:self.view backImg: kNavBackImgName homeImg:nil];
    [self setUpTabelView];
    // Do any additional setup after loading the view.
}
- (void)setUpTabelView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    if (kDeviceVersion>=7.0) {
        [_tableView setFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    }else{
        [_tableView setFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-64)];
    }
    [_tableView setBackgroundColor:kViewBackGroudColor];
    [_tableView setBackgroundView:nil];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    if (kDeviceVersion>=7.0) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 5)];

    }
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self setExtraCellLineHidden:_tableView];
    [self.view addSubview:_tableView];
    
    //setDataSource
    _listArr = [UserInfoSample shareInstance].listItems[@"list"];
}
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    [view setBackgroundColor:[UIColor clearColor]];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.textLabel setText:_listArr[indexPath.row][@"name"]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.detailTextLabel setText:_listArr[indexPath.row][@"publishedDate"]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected___row %d",indexPath.row);
    NoticeViewController *nvc;
    if (IS_IPHONE4) {
        nvc = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController35" bundle:nil];
    }else if (IS_IPHONE5){
        nvc = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController" bundle:nil];
    }
    
    nvc.noticeId = [UserInfoSample shareInstance].listItems[@"list"][indexPath.row][@"id"];
    [self.navigationController pushViewController:nvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
