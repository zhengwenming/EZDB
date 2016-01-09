//
//  CardViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-28.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//
#import "CardViewController.h"
#import "QueryCardListDataRequest.h"
#import "AddCardViewController.h"
#import "SetPayPwdViewController.h"
#import "PerCenterVController.h"
#import "PayPwdVController.h"
#import "LoginViewController.h"
#import "CardCell.h"
#import "CardModel.h"

#define DEBUGTEST 1
#define kSecuStar @"**** **** **** ***"
@interface CardViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIAlertViewDelegate>
{
    NSMutableArray *modelArry;
    NSMutableString *cardNoStr;
}
@end

@implementation CardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        modelArry = [NSMutableArray array];
        cardNoStr = [NSMutableString string];
    }
    return self;
}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        NSLog(@"___index");
            [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
//    [self loadCardList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];

}
//加载卡列表
//- (void)loadCardList
//{
//#ifdef DEBUGTEST
//    BOCHud *hub = [[BOCHud alloc]initWithFrame:self.view.frame];
//    hub.labelText = @"数据加载中...";
//    [self.view addSubview:hub];
//    [hub startAnimating:4];
//    BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
//    
//    QueryCardListDataRequest *request = [QueryCardListDataRequest requestWithHeaders:nil];
//    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
//    //报文头
//    request.headers = headers;
//    //参数   //测试custNo @"1234674652"
//    NSDictionary *bodyParameters = @{@"custNo":[UserInfoSample shareInstance].userItems[@"uid"]};
////    NSDictionary *bodyParameters = @{@"custNo":@"1234674652"};
//
//    request.postJSON = [bodyParameters JSONString];
//    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
//        NSLog(@"response:___ card list %@",result);
//        if ([result[@"serviceResponse"][@"responseCode"]isEqualToString:_responseCode_Card_Done]) {
//            NSArray * jsonArry= [NSMutableArray arrayWithArray:[result objectForKey:@"custCardList"]];
//            for (int i=0; i<jsonArry.count; i++ ) {
//                CardModel *model = [[CardModel alloc]init];
//                model.cardNO = [jsonArry[i] objectForKey:@"cardNo"];
//                model.cardType = [jsonArry[i] objectForKey:@"actName"];
//                model.bankLogo = [jsonArry[i] objectForKey:@"bankId"];
//                model.cardMobile = [jsonArry[i] objectForKey:@"cardMobile"];
//                model.openBank = [jsonArry[i] objectForKey:@"openBank"];
//                [UserInfoSample shareInstance].bankId = [jsonArry[i] objectForKey:@"bankId"];
//                
//                [modelArry addObject:model];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.cardTableView reloadData];
//                [hub removeForever];
//            });
//        }else{
//            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
//            [self showNBAlertWithAletTag:114 Title:@"温馨提示" content:result[@"serviceResponse"][@"responseMsg"] btnArray:arr];
//        }
//    }];
//    [request onRequestFailWithError:^(NSError *error) {
//        [hub removeForever];
//        __Login_Invailid_;
//    }];
//    [request connect];
//#else
//#endif
//}
- (void)initUI
{
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:@"银行卡管理" lBtnImg:@"ico_back.png" rBtnImg:nil];
    }else{
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:@"银行卡管理" lBtnImg:@"ico_back.png" rBtnImg:nil];
        self.cardTableView.frame = CGRectMake(0, 0, kScreenWidth, 330);
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y -= 20;
            v.frame = rect;
        }
    }
    self.navView.delegate = (id<PopViewContrlDelegate>)self;
    [self.view addSubview:self.navView];
    
    self.cardTableView.dataSource = self;
    self.cardTableView.delegate = self;
    self.cardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.cardTableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    self.bottomView.layer.cornerRadius = 5;
    self.bottomView.layer.borderWidth = 1;
    self.bottomView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addCard:)];
    [self.bottomView addGestureRecognizer:tap];
 
}
#pragma mark - 新增银行卡
- (void)addCard:(UIButton *)sender
{
   if ([UserInfoSample shareInstance].isSetPayPwd) {

       PayPwdVController *payVC = [[PayPwdVController alloc]initWithNibName:@"PayPwdVController" bundle:nil];
       [self.navigationController pushViewController:payVC animated:YES];
    }else{
//        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"立即设置",@"返回", nil];
//        [self showNBAlertWithAletTag:113 Title:@"非常抱歉，操作失败" content:@"您尚未设置直销银行支付密码，为了您的账户及资金安全，建议立即设置。" btnArray:arr];
        PayPwdVController *payVC = [[PayPwdVController alloc]initWithNibName:@"PayPwdVController" bundle:nil];
        [self.navigationController pushViewController:payVC animated:YES];
    }
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    CardModel *model = modelArry[indexPath.row];
//    
//    NSString *bstring =  [model.cardNO substringFromIndex:(model.cardNO.length-4)];
//    NSMutableString *bStr = [NSMutableString stringWithFormat:@"%@",bstring];
//    [bStr insertString:@" " atIndex:1];
//    cardNoStr = [NSMutableString stringWithFormat:@"%@%@",kSecuStar,bStr];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.numberLabel.text = cardNoStr;
//    if (model.cardType.length>10) {
//        model.cardType = @"";
//    }
//    cell.typeLabel.text = model.cardType;
//    cell.bankNameLabel.text = model.openBank;
//    [MSUtil judgeBankIDWith:model.bankLogo img:cell.logoIV];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark - SelectRowCell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CardInfoViewController *cardInfoVC = [[CardInfoViewController alloc]initWithBlock:^(id obj) {
//        NSLog(@"obj==%@",obj);
//        CardModel *model = modelArry[indexPath.row];
//        model.cardType = obj;
//
//        [self.cardTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }];
//    CardModel *model = modelArry[indexPath.row];
//    cardInfoVC.typeString = model.cardType;
//    cardInfoVC.logoString = model.bankLogo;
//    NSString *bstring =  [model.cardNO substringFromIndex:(model.cardNO.length-4)];
//    NSMutableString *bStr = [NSMutableString stringWithFormat:@"%@",bstring];
//    [bStr insertString:@" " atIndex:1];
//    cardNoStr = [NSMutableString stringWithFormat:@"%@%@",kSecuStar,bStr];
//    cardInfoVC.NumberString = cardNoStr;
//    cardInfoVC.cardNo = model.cardNO;
//    NSLog(@"____ cardNo %@",cardInfoVC.NumberString);
//    [self.navigationController pushViewController:cardInfoVC animated:YES];
//    }
}

//#pragma mark - NBAlertViewDelegate
//- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if ([alertView tag]==111) {
//        [alertView close];
//        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
//                                @"LoginViewController",
//                                @"LoginViewController4");
//    }else if([alertView tag]==113){
//        [alertView close];
//        switch (buttonIndex) {
//            case 0:{
//                GOTO_NEXTVIEWCONTROLLER(SetPayPwdViewController,
//                                    @"SetPayPwdViewController",
//                                    @"SetPayPwdViewController4");
//            }
//                break;
//            case 1:
//                [alertView close];
//                break;
//            default:
//                break;
//        }
//    }else if([alertView tag]==114){
//        [alertView close];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.cardTableView.delegate = nil;
    self.cardTableView.dataSource = nil;
}
@end
