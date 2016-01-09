//
//  RegSuccessViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "RegSuccessViewController.h"
#import "SetPayPwdViewController.h"
#import "LoginViewController.h"
#import "BorderSetBtn.h"

@interface RegSuccessViewController ()

@end

@implementation RegSuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - buttonClick

//set pay password
- (IBAction)setPayPwd:(UIButton *)sender
{
    GOTO_NEXTVIEWCONTROLLER(LoginViewController, @"LoginViewController",
                            @"LoginViewController4");
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    if (index==1) {
//        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==2){
       
    }
}
- (void)initUI
{

    [self setNavBarWithtitle:kRegisterTitle superView:self.view backImg:nil homeImg:nil];
    if (kDeviceVersion>=7.0) {
    }else{
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y += 20;
        }
        self.remView = [[UIImageView alloc]initWithFrame:CGRectMake(137, 87, 47, 42)];
        self.remView.image = [UIImage imageNamed:@"ico_finish.png"];
        [self.view addSubview:self.remView];
    }
      
    self._congratulationLabel.textColor = kBLueColor;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
