//
//  redeemRuleController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "redeemRuleController.h"

@interface redeemRuleController ()

@end

@implementation redeemRuleController

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
    [self setNavBarWithtitle:@"赎回" superView:self.view backImg:kNavBackImgName homeImg:nil];
    self.view.backgroundColor=kViewBackGroudColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
