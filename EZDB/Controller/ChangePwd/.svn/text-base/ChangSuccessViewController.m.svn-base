//
//  ChangSuccessViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-19.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ChangSuccessViewController.h"
#import "LoginViewController.h"
#import "BorderSetBtn.h"

@interface ChangSuccessViewController ()

@end

@implementation ChangSuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backHome:(UIButton *)sender
{
    [self backHomeVc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==2){
        
    }
}
- (void)initUI{
    
    [self setNavBarWithtitle:@"修改登录密码" superView:self.view backImg:kNavBackImgName homeImg:nil];
    
    self.reLoginButton.backgroundColor = kBtnBackGroudColor;
    [self.reLoginButton addTarget:self action:@selector(reLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backHomeButton.backgroundColor = kRegBackGroudColor;
    [self.backHomeButton addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchUpInside];
    
    self.congratulationLabel.textColor = kBLueColor;
}

- (void)reLoginAction:(UIButton *)sender
{
    GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                            @"LoginViewController",
                            @"LoginViewController4");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
