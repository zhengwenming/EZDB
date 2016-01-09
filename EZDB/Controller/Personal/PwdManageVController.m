//
//  PwdManageVController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PwdManageVController.h"
#import "LoginViewController.h"
#import "SetPayPwdViewController.h"
#import "UpdPwdViewController.h"
#import "ChangePwdViewController.h"
#import "QueryVCPPwdRequest.h"

#define kPwdManNavTitle @"密码管理"
//BOCOPPAY_URL_LOGOUT
@interface PwdManageVController ()

@end

@implementation PwdManageVController

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
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
//    [self queryVCPPwd];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupSubViews
{
    [self setNavBarWithtitle:kPwdManNavTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_coverView setFrame:CGRectMake(0, kNavbarHeight, kScreenWidth, kScreenHeight)];
    [_coverView setBackgroundColor:kViewBackGroudColor];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}




//修改登录密码
- (IBAction)loginPwdUpd:(UIButton *)sender
{
    GOTO_NEXTVIEWCONTROLLER(ChangePwdViewController,@"ChangePwdViewController35", @"ChangePwdViewController");
}

//设置或修改支付密码
- (IBAction)payPwdSetAndUpd:(UIButton *)sender
{
    if (![UserInfoSample shareInstance].isSetPayPwd){
        GOTO_NEXTVIEWCONTROLLER(SetPayPwdViewController,@"SetPayPwdViewController", @"SetPayPwdViewController4");
    }else if ([UserInfoSample shareInstance].isSetPayPwd){
        GOTO_NEXTVIEWCONTROLLER(UpdPwdViewController,@"UpdPwdViewController", @"UpdPwdViewController4");
//        GOTO_NEXTVIEWCONTROLLER(SetPayPwdViewController,@"SetPayPwdViewController", @"SetPayPwdViewController4");

    }
}
#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];
    if ([alertView tag]==111) {
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
