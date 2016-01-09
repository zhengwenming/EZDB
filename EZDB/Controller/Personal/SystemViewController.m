//
//  SystemViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "SystemViewController.h"
#import "ChangePwdViewController.h"
#import "SetPayPwdViewController.h"
#import "UpdPwdViewController.h"
#import "HelpCenterViewController.h"
#import "BOCOLogoutRequest.h"

#define kSysNavTitle @"系统中心"

@interface SystemViewController ()<PopViewContrlDelegate,UIAlertViewDelegate>

@end

@implementation SystemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    switch (index) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.logOutView setFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45)];
    
    if (kDeviceVersion>=7.0) {
        [self setNavBarWithtitle:kSysNavTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
    }else{
        
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y -= 20;
            v.frame = rect;
        }
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.logOutView.frame.origin.x, self.logOutView.frame.origin.y, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineView];
        [self setNavBarWithtitle:kSysNavTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
        
    }
    //new字样
    EZDBAppDelegate *dele = (EZDBAppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"======= ___%hhd",dele.isExisted);
    if (!dele.isExisted) {
        [self.nVersionView removeFromSuperview];
        [self.version setText:@"当前为最新版本"];
    }else{
        [self.version setText:@""];
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}

#pragma mark -
- (IBAction)logOutClick:(UIButton *)sender
{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定",@"取消", nil];
    [self showNBAlertWithAletTag:1 Title:@"温馨提示" content:@"您确定要退出吗？" btnArray:arr];
}
//帮助中心跳转
- (IBAction)HelpCenterClick:(UIButton *)sender
{
    GOTO_NEXTVIEWCONTROLLER(HelpCenterViewController,
                            @"HelpCenterViewController35",
                            @"HelpCenterViewController");

}
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag]==1) {
        [alertView close];
        switch (buttonIndex) {
            case 0:{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
                
                BOCOLogoutRequest *request = [BOCOLogoutRequest requestWithHeaders:nil];
                NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
                //报文头
                request.headers = headers;
                
                [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    NSLog(@"LOGOUT___ is * result %@ cde %@",result,result[@"msgcde"] );
                    if ([result[@"msgcde"]isEqualToString:@"ASR-000000"]) {
                        
                        [BOCOPLogin sharedInstance].isLogin = NO;
                        [[BOCOPLogin sharedInstance]logOut];
                    }else{
                        NSLog(@"LOGOUT___ is * result msg %@",result[@"rtnmsg"] );
                        [self showNBAlertWithAletTag:2 Title:@"温馨提示" content:result[@"rtnmsg"] btnArray:[NSMutableArray arrayWithObjects:@"确定", nil]];
                    }
                }];
                [request onRequestFailWithError:^(NSError *error) {
                    NSLog(@"fail to .....");
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([[error userInfo][@"error_code"] isEqualToString:@"ASR-000000"]){
                        [[BOCOPLogin sharedInstance]logOut];
                        [BOCOPLogin sharedInstance].isLogin = NO;
                        [self backHomeVc];
                    }else if ([[error userInfo][@"error_code"] isEqualToString:@"ASR-000003"]||
                              [[error userInfo][@"error_code"] isEqualToString:@"ASR-000005"]||
                              [[error userInfo][@"error_code"]isEqualToString:@"invalid_token"]){
                        //登录失效
                        NSLog(@"error_description %@",[error userInfo][@"error_description"]);
                        [BOCOPLogin sharedInstance].isLogin = NO;
                        [[BOCOPLogin sharedInstance]logOut];
                        [self backHomeVc];
                    }else{
                        [self showNBAlertWithAletTag:5 Title:@"温馨提示" content:[error userInfo][@"error_description"] btnArray:[NSMutableArray arrayWithObjects:@"确定", nil]];
                    }
                }];
                [request connect];
            }
                break;
                
            default:
                break;
        }
    }else if ([alertView tag]==2){
        [alertView close];
        [BOCOPLogin sharedInstance].isLogin = NO;
        [[BOCOPLogin sharedInstance]logOut];
        [self backHomeVc];
        
    }else if ([alertView tag]==3){
        [alertView close];
        [BOCOPLogin sharedInstance].isLogin = NO;
        [[BOCOPLogin sharedInstance]logOut];
        [self backHomeVc];
    }else if ([alertView tag]==4){
        [alertView close];
        switch (buttonIndex) {
            case 0:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[EZDBAppDelegate appDelegate].appUrl]];
                break;
            case 1:
                break;
            default:
                break;
        }
    }else if ([alertView tag]==5||
              [alertView tag]==6){
        [alertView close];
    }
}

//版本检测
- (IBAction)versionCheck:(UIButton *)sender
{
    EZDBAppDelegate *dele = (EZDBAppDelegate *)[UIApplication sharedApplication].delegate;
    if (dele.isExisted) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"立即更新",@"取消", nil];
        [self showNBAlertWithAletTag:4 Title:@"温馨提示" content:@"有新的版本可供更新,是否立即更新?" btnArray:arr];
        
    }else if (!dele.isExisted){
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
        [self showNBAlertWithAletTag:5 Title:@"温馨提示" content:@"您当前版本为最新版本,无需更新" btnArray:arr];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
