//
//  ChangePwdViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-19.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "ChangSuccessViewController.h"
#import "LoginViewController.h"
#import "BOCOLogoutRequest.h"
#include "Base64Transcoder.h"
#import "BorderSetBtn.h"
#import "ReviseLogPwdRequest.h"
#import "QueryTwoPwdsRequest.h"

#define kLogOut  1
typedef enum : NSUInteger {
    kCheckPwdRequest = 11,
    kChangePwdRequest,
} kRequestTpye;

@interface ChangePwdViewController ()

@end

extern int __counter;

@implementation ChangePwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"__counter %d",__counter);

    [self initUI];
//    [self setPwdTf];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    
        [self.navigationController popViewControllerAnimated:YES];
   
    
}
-(void)initUI
{
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:@"修改登录密码" lBtnImg:kNavBackImgName rBtnImg:nil];
    }else {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:@"修改登录密码" lBtnImg:kNavBackImgName rBtnImg:nil];

    }
    self.navView.delegate = (id<PopViewContrlDelegate>)self;
    [self.view addSubview:self.navView];


}
- (void)dealloc
{
    __counter = 1;
}

@end
