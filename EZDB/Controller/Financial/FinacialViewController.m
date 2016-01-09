//
//  FinacialViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "FinacialViewController.h"
#import "DetailViewController.h"
#import "FundListDataRequest.h"
#import "FunListModel.h"
#import "BorderSetBtn.h"
#import "FundCell.h"
#import "PurchaseViewController.h"

@interface FinacialViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *imgArr;
    MBProgressHUD  *_hub;
}
@end

@implementation FinacialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataArr = [NSMutableArray array];
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    return self;
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBar];
    [self setSubViews];
//    [self sendRequest];
    //基金列表
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setTableView
- (void)setSubViews
{
//    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _hub.labelText = @"数据加载中...";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
    [_tableView registerNib:[UINib nibWithNibName:@"FundCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

}


#pragma mark - 立即购买
- (void)buyBtnAction:(UIButton *)button
{

        PurchaseViewController *purVC = [[PurchaseViewController alloc]initWithNibName:@"PurchaseViewController" bundle:nil];

       [self.navigationController pushViewController:purVC animated:YES];

    
    
}
#pragma mark - 了解更多
- (void)checkDetail:(UIButton *)sender
{
    DetailViewController *dvc = [[DetailViewController alloc]init];
    
    [self.navigationController pushViewController:dvc animated:YES];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FundCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
    [cell.buyBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.buyBtn setTag:indexPath.row+2];
//
    [cell.moreBtn addTarget:self action:@selector(checkDetail:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.moreBtn setTag:indexPath.row+1];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 229;
}


#pragma mark - NavBar
- (void)setNavBar
{
    [self setNavBarWithtitle:@"我要理财" superView:self.view backImg:nil homeImg:nil];
}
- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
}


@end
