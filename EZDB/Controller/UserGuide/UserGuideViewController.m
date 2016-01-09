//
//  UserGuideViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-14.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "UserGuideViewController.h"


@interface UserGuideViewController () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}

@end

@implementation UserGuideViewController

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
    [self initGuideView];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initGuideView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *iPhone4Array = @[@"iPhone4-1",@"iPhone4-2",@"iPhone4-3"];
    NSArray *iPhone5Array = @[@"iPhone5-1",@"iPhone5-2",@"iPhone5-3"];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (IS_IPHONE5){
        aButton.frame = CGRectMake(100+2*kScreenWidth-5, 376, 130, 45);
        for (NSUInteger i = 0; i<3; i++) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];

            iv.image = [UIImage imageNamed:iPhone5Array[i]];
            NSLog(@"%@",iPhone4Array[i]);
            [_scrollView addSubview:iv];
        }
    }else if (IS_IPHONE4){
        aButton.frame = CGRectMake(100+2*kScreenWidth-5, 300, 130, 45);
        for (NSUInteger i = 0; i<3; i++)
        {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];

            iv.image = [UIImage imageNamed:iPhone4Array[i]];
            NSLog(@"%@",iPhone4Array[i]);
            [_scrollView addSubview:iv];
        }
    }

    aButton.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:aButton];
    [_scrollView bringSubviewToFront:aButton];

    
}

- (void)buttonAction:(UIButton *)sender
{
    [EZDBAppDelegate appDelegate].tabBarCtl = [[TabBarViewController alloc]init];
    [EZDBAppDelegate appDelegate].tabBarCtl.viewControllers = [[EZDBAppDelegate appDelegate].tabBarCtl getViewcontrollers];
    [EZDBAppDelegate appDelegate].window.rootViewController = [EZDBAppDelegate appDelegate].tabBarCtl;
    
    
    //隐藏系统的tabar view
    for (UIView * v in [EZDBAppDelegate appDelegate].tabBarCtl.view.subviews) {
        
        if ([v isKindOfClass:[UITabBar class]]) {
            v.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
        }else{
            v.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, kScreenHeight);
        }
    }

    
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.4];
    [transition setType:@"moveIn"];
    [transition setSubtype:@"fromBottom"];
    [[EZDBAppDelegate appDelegate].window.layer addAnimation:transition forKey:nil];
}
- (void)dealloc
{
    NSLog(@"%@",self);
}


@end
