//
//  TabBarViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "TabBarViewController.h"
#import "FinacialViewController.h"
#import "BlankViewController.h"
#import "LoginViewController.h"
#import "PerCenterVController.h"
#import "AssetViewController.h"
//#import "NoCardPurVController.h"
//#import "UpdPwdViewController.h"
//#import "ChangePwdViewController.h"

@interface TabBarViewController ()<UITabBarDelegate>
{
    UIView       *_customTabbarView;
    CGFloat        orginHeight;
    NSArray       *tabBarItems;
}
@end


@implementation TabBarViewController

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
    [self customTabbarViewAndButton];
    // Do any additional setup after loading the view.
}

- (void)customTabbarViewAndButton
{
    self.viewControllers = [self getViewcontrollers];
    //隐藏系统的tabbar
    self.tabBar.hidden = YES;
    orginHeight = kScreenHeight-kTabBarHeight;
    _customTabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, orginHeight, kScreenWidth, kTabBarHeight)];
    //tabbar背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _customTabbarView.frame.size.width, _customTabbarView.frame.size.height)];
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, 1)];

    
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [imageView addSubview:lineView];
    [_customTabbarView addSubview:imageView];
    [self.view addSubview:_customTabbarView];
    
    int buttonWidth = kScreenWidth/4;
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    NSArray *titleNames = [NSArray arrayWithObjects:
                                           @"首页",
                                           @"理财",
                                           @"资产",
                                           @"设置", nil];
    
    NSArray *imgNames = [NSArray arrayWithObjects:
                                            @"ico_home_off",
                                            @"ico_financial",
                                            @"ico_asset",
                                            @"ico_system", nil];
    
    NSArray *imgHiNames = [NSArray arrayWithObjects:
                                           @"ico_home_on",
                                           @"ico_financial_on",
                                           @"ico_asset",
                                           @"ico_system_on", nil];
    
    for (int i=0; i<4; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setTag:i+1];
        [button setFrame:CGRectMake(buttonWidth*i, 0, buttonWidth, _customTabbarView.frame.size.height)];
        [button setTitle:titleNames[i] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:182/255.0 green:0 blue:42/255.0 alpha:1] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:imgHiNames[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0){
            button.selected = YES;
        }
        [_customTabbarView addSubview:button];
    }
}

- (void)buttonPress:(UIButton *)selectedButton
{
    NSLog(@"_  ___ click");
    self.selectedIndex = selectedButton.tag-1;
    for (int i=0; i<4; i++)
    {
        UIButton *button = (UIButton *)[_customTabbarView viewWithTag:i+1];
        button.selected = NO;
        if (i==3) {
            if ([BOCOPLogin sharedInstance].isLogin) {
                TabBarViewController *tbar = (TabBarViewController *)[EZDBAppDelegate appDelegate].window.rootViewController;
                NSMutableArray *newViewControllers = [NSMutableArray array];
                for (int i=0; i<tbar.viewControllers.count; i++) {
                    UIViewController *vc = [tbar.viewControllers objectAtIndex:i];
                    if (i==3) {
                        PerCenterVController *pVC;
                        if (IS_IPHONE5) {
                            pVC = [[PerCenterVController alloc]initWithNibName:@"PerCenterVController" bundle:nil];
                        }else if(IS_IPHONE4){
                            pVC = [[PerCenterVController alloc]initWithNibName:@"PerCenterVController35" bundle:nil];
                        }
                        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:pVC];
                        [newViewControllers addObject:nav];
                    }else{
                        [newViewControllers addObject:vc];
                    }
                }
                tbar.viewControllers = newViewControllers;
                [EZDBAppDelegate appDelegate].window.rootViewController = tbar;
            }else{
                TabBarViewController *tbar = (TabBarViewController *)[EZDBAppDelegate appDelegate].window.rootViewController;
                NSMutableArray *newViewControllers = [NSMutableArray array];
                for (int i=0; i<tbar.viewControllers.count; i++) {
                    UIViewController *vc = [tbar.viewControllers objectAtIndex:i];
                    if (i==3) {
                        PerCenterVController *pVC;
                        if (IS_IPHONE5) {
                            pVC = [[PerCenterVController alloc]initWithNibName:@"PerCenterVController" bundle:nil];
                        }else if(IS_IPHONE4){
                            pVC = [[PerCenterVController alloc]initWithNibName:@"PerCenterVController" bundle:nil];
                        }
                        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:pVC];
                        NSLog(@"unlogin unlogin__ **");

                        [newViewControllers addObject:nav];
                    }else{
                        [newViewControllers addObject:vc];
                    }
                }
                tbar.viewControllers = newViewControllers;
                [EZDBAppDelegate appDelegate].window.rootViewController = tbar;
            }
            CATransition *transition = [CATransition animation];
            [transition setDuration:0.4];
            [transition setType:@"fade"];
            [self.view.layer addAnimation:transition forKey:nil];
            
        }else if (i==2){

                    TabBarViewController *tbar = (TabBarViewController *)[EZDBAppDelegate appDelegate].window.rootViewController;
                    NSMutableArray *newViewControllers = [NSMutableArray array];
                    for (int i=0; i<tbar.viewControllers.count; i++) {
                        UIViewController *vc = [tbar.viewControllers objectAtIndex:i];
                        if (i==2) {
                            BlankViewController *blankVC= [[BlankViewController alloc]init];
                            UINavigationController *blakNav = [[UINavigationController alloc]initWithRootViewController:blankVC];
                            [newViewControllers addObject:blakNav];
                        }else{
                            [newViewControllers addObject:vc];
                        }
                    }
                    tbar.viewControllers = newViewControllers;
                    [EZDBAppDelegate appDelegate].window.rootViewController = tbar;
                CATransition *transition = [CATransition animation];
                [transition setDuration:0.4];
                [transition setType:@"fade"];
                [self.view.layer addAnimation:transition forKey:nil];
        }else if (i==1) {
            if (![BOCOPLogin sharedInstance].isLogin) {
                TabBarViewController *tbar = (TabBarViewController *)[EZDBAppDelegate appDelegate].window.rootViewController;
                NSMutableArray *newViewControllers = [NSMutableArray array];
                for (int i=0; i<tbar.viewControllers.count; i++) {
                    UIViewController *vc = [tbar.viewControllers objectAtIndex:i];
                    if (i==1) {
                        FinacialViewController *pVC = [[FinacialViewController alloc]initWithNibName:@"FinacialViewController" bundle:nil];
                        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:pVC];
                        [newViewControllers addObject:nav];
                    }else{
                        [newViewControllers addObject:vc];
                    }
                }
                tbar.viewControllers = newViewControllers;
                [EZDBAppDelegate appDelegate].window.rootViewController = tbar;
            }
            CATransition *transition = [CATransition animation];
            [transition setDuration:0.4];
            [transition setType:@"fade"];
            [self.view.layer addAnimation:transition forKey:nil];
        
        }
        selectedButton.selected = YES;
    }
}

- (NSArray *)getViewcontrollers
{
    DEFINE_CONTROLLERS(RootViewController, nav1);
    DEFINE_CONTROLLERS(FinacialViewController, nav2);
    
    UINavigationController *nav3;
    if ([BOCOPLogin sharedInstance].isLogin) {
        BlankViewController *blankVC = [[BlankViewController alloc]init];
        nav3 =[[UINavigationController alloc]initWithRootViewController:blankVC];
    }else{
        FinacialViewController *login = [[FinacialViewController alloc]init];
        nav3 =[[UINavigationController alloc]initWithRootViewController:login];
    }
    
    FinacialViewController *loginVC;
    UINavigationController *nav4;
            if (IS_IPHONE5) {
            loginVC = [[FinacialViewController alloc]initWithNibName:@"FinacialViewController" bundle:nil];
        }else if(IS_IPHONE4){
            loginVC = [[FinacialViewController alloc]initWithNibName:@"FinacialViewController" bundle:nil];
        }
        nav4 = [[UINavigationController alloc]initWithRootViewController:loginVC];
    tabBarItems = @[nav1,nav2,nav3,nav4];
    return tabBarItems;
}

- (void)hideMyTabBar
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _customTabbarView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kTabBarHeight);
    }];
}

- (void)showMyTabBar
{
    [UIView animateWithDuration:0.5 animations:^{
        _customTabbarView.frame = CGRectMake(0, orginHeight, kScreenWidth, kTabBarHeight);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
