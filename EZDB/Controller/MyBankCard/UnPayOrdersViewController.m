//
//  UnPayOrdersViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "UnPayOrdersViewController.h"
#import "UnPayOrdersCell.h"
#import "FundListDataRequest.h"



@interface UnPayOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * unPayTableView;
    UIView * noOrderSView;
    NSMutableArray * dataArray;
}
@end

@implementation UnPayOrdersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
    [self setTableView];
//    [self setNoOrdersView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    switch (index) {
        case 1:{
          UIViewController * testVC=  self.navigationController.childViewControllers[0];
            [self.navigationController popToViewController:testVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 数据请求

- (void)sendRequest
{
    NSDictionary *params = @{
                             @"signType":@"0",
                             @"signChannel":@"0",
                             @"businessCode":@"001",
                             @"uuid":@""};
    
    BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
    FundListDataRequest *request = [FundListDataRequest requestWithHeaders:nil];
    
    NSMutableDictionary *headParameters = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
    
    request.headers = headParameters;
    request.postJSON = [params JSONString];
    
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"success______unPayOrdersList %@",result);
        
        
               dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
    
    [request onRequestFailWithError:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"fail______unPayOrdersList %@",error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:[error userInfo][@"error_description"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.tag = 110;
        [alert show];
        
    }];
    [request connect];
}
#pragma mark- UI
-(void)setNoOrdersView
{
    noOrderSView=[[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView * flagImage=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-54)/2, kScreenHeight/2-92, 54, 52)];
    flagImage.image=[UIImage imageNamed:@"img_no"];
    UILabel * noOrderLabel=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-215)/2,kScreenHeight/2-30 , 215, 35)];
    noOrderLabel.text=@"暂无未支付订单";
    noOrderLabel.textColor=[UIColor groupTableViewBackgroundColor];
    noOrderLabel.font=[UIFont systemFontOfSize:30];
    [noOrderSView addSubview:flagImage];
    [noOrderSView addSubview:noOrderLabel];
    [self.view addSubview:noOrderSView];
    
}

-(void)setTableView
{
    if (kDeviceVersion>=7.0) {
           unPayTableView= [[UITableView alloc]initWithFrame:CGRectMake(0,44,kScreenWidth,self.view.frame.size.height-44) style:UITableViewStylePlain];
    }else{
        unPayTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, self.view.frame.size.height-44) style:UITableViewStylePlain];
    }

    unPayTableView.dataSource = self;
    unPayTableView.delegate = self;
    unPayTableView.rowHeight=170;
    if (kDeviceVersion>=7.0) {
        unPayTableView.separatorInset=UIEdgeInsetsZero;
        unPayTableView.separatorColor=[UIColor groupTableViewBackgroundColor];

    }
    unPayTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [unPayTableView registerNib:[UINib nibWithNibName:@"UnPayOrdersCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:unPayTableView];
    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnPayOrdersCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.sumOfMoneyLabel.text=@"10000,00.00  ";
    cell.cardNumberLabel.text=@"中国银行 尾号1234";
    cell.orderNumberLabel.text=@"订单号：12344567788899";
    cell.orderTimeLabel.text=@"2014.11.12 14:12";
    cell.fundNameLabel.text=@"天宏基金";
    return cell;
}

-(void)dealloc
{
    unPayTableView.delegate=nil;
    unPayTableView.dataSource=nil;
}
@end
