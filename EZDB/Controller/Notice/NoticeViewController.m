//
//  NoticeViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-1.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "NoticeViewController.h"
#import "DbNoticeListRequest.h"
#import "DbNoticeDetailRequest.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        if ([BOCOPLogin sharedInstance].isLogin) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
            [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(index==2){


    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
//    [self loadNoticeDetail];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}
- (void)initNav
{
    [self setNavBarWithtitle:@"消息公告" superView:self.view backImg:kNavBackImgName homeImg:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
