//
//  RedemptionFailureViewController.m
//  EZDB
//
//  Created by tk on 14-11-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "RedemptionFailureViewController.h"
#import "RedemptionCell.h"
#import "RedemptionDailureController.h"
#import "WarnCardReplaceRequest.h"
#import "RedeemDailureModel.h"

@interface RedemptionFailureViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataSource;
    MBProgressHUD *_hud;
    
}
@end

@implementation RedemptionFailureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE5) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight+20) style:UITableViewStylePlain];

    }else if (IS_IPHONE4){
        if (kDeviceVersion<7.0) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-44-44+23) style:UITableViewStylePlain];

        }else{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
 
        }

    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (kDeviceVersion>=7.0) {
        _tableView.separatorInset = UIEdgeInsetsZero;

    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setNav];
    [self loadHistoryDetail];
    
    // Do any additional setup after loading the view.
}
-(void)loadHistoryDetail{
    BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
    WarnCardReplaceRequest *request = [WarnCardReplaceRequest requestWithHeaders:nil];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
    //报文头
    request.headers = headers;
    //参数
//    NSDictionary *bodyParameters =@{@"userId":[BOCOPLogin sharedInstance].userName,
//                                    };
    NSDictionary *bodyParameters =@{@"userId":@"0004"
                                    };

    request.postJSON = [bodyParameters JSONString];
    
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        NSLog(@"赎回失败换卡提醒 返回数据 %@",result);
//        for (NSDictionary *dic in result[@"failOrderNum"]) {
//            RedeemDailureModel *model = [[RedeemDailureModel alloc] init];
//            model.fundName = dic[@""];
//            model.openBank = dic[@""];
//            model.redeemShare = dic[@""];
//            model.orderStatus = dic[@""];
//            model.transactionData = dic[@""];
//            [dataSource addObject:model];
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });

    }];
                       
    [request onRequestFailWithError:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    [request connect];
    
}


-(void)setNav
{
    [self setNavBarWithtitle:@"赎回失败"  superView:self.view backImg:kNavBackImgName homeImg:nil];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedemptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RedemptionCell" owner:self options:nil]firstObject];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:.2f];
    }
//    RedeemDailureModel *model = [dataSource objectAtIndex:indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.redemptionName.text = @"广发基金盆满钵盈利赢";
    cell.redemptionState.text = @"交易失败";
    cell.redemptionTime.text = @"2014.10.6 16:13";
    cell.redemptionBank.text = @"中国银行 0217";
    cell.redemptionMoney.text = @"15,000.00";
    return cell;
}



-(void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedemptionDailureController *rdc = [[RedemptionDailureController alloc] initWithNibName:@"RedemptionDailureController" bundle:nil];
//    RedeemDailureModel *model = [dataSource objectAtIndex:indexPath.row];
//    rdc.failOrderNo = model.failOrderNo;
//    rdc.fundNameNext = model.fundName;
//    rdc.transactionData = model.transactionData;
//    rdc.transactionType = model.transactionType;
//    rdc.orderStatus = model.orderStatus;
//    rdc.statusDescrition = model.statusDescription;
//    rdc.redeemShare = model.redeemShare;
//    rdc.bankId = model.bankId;
//    rdc.openBank = model.openBank;
//    rdc.cardNo = model.cardNo;
//    rdc.cardSep = model.cardSep;
    [self.navigationController pushViewController:rdc animated:YES];
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
