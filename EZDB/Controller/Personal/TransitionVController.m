//
//  TransitionVController.m
//  EZDB
//
//  Created by Haitao.Li on 14/11/12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "TransitionVController.h"
//#import "RedemptionFailureViewController.h"
#import "ChangeCardViewController.h"
#define kTranNavName @"待处理交易"
@interface TransitionVController ()

@end

@implementation TransitionVController

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
    [self setNavBarWithtitle:kTranNavName superView:self.view backImg:kNavBackImgName homeImg:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)redemption:(id)sender {
  
}
@end
