//
//  TransactionDetailController.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "TransactionDetailController.h"
#import "QureyHistoryDetailRequest.h"

@interface TransactionDetailController ()

@end

@implementation TransactionDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (index==2){
        
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];

}


- (void)initUI
{
    [self setNavBarWithtitle:@"交易明细" superView:self.view backImg:kNavBackImgName homeImg:nil];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
