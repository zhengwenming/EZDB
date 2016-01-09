//
//  BOCProtocalViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCProtocalViewController.h"

@interface BOCProtocalViewController ()<PopViewContrlDelegate>

@end

@implementation BOCProtocalViewController

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
    [self initUI];
}
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==2){
       
    }
}
- (void)initUI
{
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:@"购买" lBtnImg:kNavBackImgName rBtnImg:nil];
    }else{
        
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44) navTitle:@"购买" lBtnImg:kNavBackImgName rBtnImg:nil];
    }
    self.navView.delegate = self;
    [self.view addSubview:self.navView];
    if (kDeviceVersion>=7.0) {
        
    }else{
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y -= 20;
            v.frame = rect;
        }
    }
    self._protocolLabel.textColor = kBLueColor;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
