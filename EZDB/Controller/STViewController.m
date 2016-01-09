//
//  STViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-27.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"
#import "NBAlertView.h"
#import "GetServerRandomRequest.h"

#define kDefaultBackgroundColor [UIColor colorWithRed:kBackgroundColorValue green:kBackgroundColorValue blue:kBackgroundColorValue alpha:1.0]

@interface STViewController ()<UIApplicationDelegate,PopViewContrlDelegate,NBAlertViewDelegate>

@end

@implementation STViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    switch (index) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setStatusBar];
    [self.view setBackgroundColor:[self getBackGroundColor]];
    self.tabBarVc = [EZDBAppDelegate appDelegate].tabBarCtl;
    for (UIView *b in self.tabBarVc.customTabbarView.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            if (b.tag==1) {
                self.homeBtn = (UIButton *)b;
            }else if (b.tag==2){
                self.finaBtn = (UIButton *)b;
            }else if (b.tag==3){
                self.AssetBtn = (UIButton *)b;
            }else if (b.tag==4){
                self.setBtn = (UIButton *)b;
            }
            // Do any additional setup after loading the view.
        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backHomeVc
{
    self.tabBarVc.selectedIndex = 0;

    if (self.setBtn.selected) {
        self.setBtn.selected = !self.setBtn.selected;
        self.AssetBtn.selected = NO;
        self.finaBtn.selected = NO;
        self.homeBtn.selected = YES;
    }else if (self.AssetBtn.selected){
        self.setBtn.selected = NO;
        self.AssetBtn.selected = !self.AssetBtn.selected;
        self.finaBtn.selected = NO;
        self.homeBtn.selected = YES;
    }else if (self.finaBtn.selected){
        self.setBtn.selected = NO;
        self.AssetBtn.selected = NO;
        self.finaBtn.selected = !self.finaBtn.selected;
        self.homeBtn.selected = YES;
    }
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.4];
    [transition setType:@"reveal"];
    [self.tabBarVc.view.layer addAnimation:transition forKey:nil];
}


- (void)showNBAlertWithAletTag:(NSInteger)alertag Title:(NSString *)title content:(NSString *)content btnArray:(NSMutableArray *)array
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 140)];
    //标题
    NSString *t = title;
    CGSize size = [t sizeWithFont:[UIFont systemFontOfSize:16]];
    NSLog(@"____ %f %f",size.width,size.height);
    
    UILabel *titleLab = [[UILabel alloc ] initWithFrame:CGRectMake((demoView.frame.size.width-size.width+30)/2,15,size.width,20)];
    titleLab.text = t;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [demoView addSubview:titleLab];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(titleLab.frame.origin.x-30, 15, 20, 20)];
    imgView.image = [UIImage imageNamed:@"ico_error"];
    [demoView addSubview:imgView];
    
    //line
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLab.frame.origin.y+titleLab.frame.size.height+8, demoView.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_change"]];
    [demoView addSubview:line];
    //文字
    UILabel *text = [[UILabel alloc ] initWithFrame:CGRectMake(20,50,demoView.frame.size.width-40,60)];
    text.text = content;
    text.numberOfLines = 0;
    text.font = [UIFont systemFontOfSize:14];
    text.textAlignment = NSTextAlignmentCenter;
    text.backgroundColor = [UIColor clearColor];
    [demoView addSubview:text];
    
    NBAlertView *alertView = [[NBAlertView alloc] init];
    [alertView setTag:alertag];
    [alertView setContainerView:demoView];
    [alertView setButtonTitles:array];
    [alertView setDelegate:self];
    [alertView setUseMotionEffects:true];
    [alertView show];
}


- (UIColor *)getBackGroundColor
{
    return kViewBackGroudColor;
    
}

#pragma mark -
- (void)setNavBarWithtitle:(NSString *)title superView:(UIView *)superview backImg:(NSString *)lImgStr homeImg:(NSString *)rImgStr
{
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:title lBtnImg:lImgStr rBtnImg:rImgStr];
    }else{
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:title lBtnImg:lImgStr rBtnImg:rImgStr];
    }
    self.navView.delegate = self;
    [superview addSubview:self.navView];
}
- (void)setStatusBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setHidden:YES];

}

- (void)creatLftBarWithViewController:(UIViewController *)viewController navTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:20]];    viewController.navigationItem.titleView = label;
    
    UIImage *backImage = [UIImage imageNamed:kNavBackImgName];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setBounds:CGRectMake(0, 0, 12, 20)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back addTarget:viewController action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    [viewController.navigationItem setLeftBarButtonItem:leftButton];

    if (kDeviceVersion>=7.0) {
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
      }else{
       
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_6"] forBarMetrics:UIBarMetricsDefault];
        [label setBackgroundColor:[UIColor clearColor]];
        [back setBounds:CGRectMake(0, 0, 12, 20)];
      }
   
    
}

- (void)creatRgtBarWithViewController:(UIViewController *)viewController navTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:20]];
    [viewController.navigationItem setTitleView:label];
    
    UIImage *backImage = [UIImage imageNamed:@"ico_home"];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setBounds:CGRectMake(0, 0, 12, 20)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back addTarget:viewController action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rgtButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    viewController.navigationItem.rightBarButtonItem = rgtButton;
    
    if (kDeviceVersion>=7.0) {
        
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    }else{
        
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_6"] forBarMetrics:UIBarMetricsDefault];
        [label setBackgroundColor:[UIColor clearColor]];
        [back setBounds:CGRectMake(0, 0, 12, 20)];
    }

}

- (void)creatBarWithViewController:(UIViewController *)viewController navTitle:(NSString *)title backImg:(NSString *)lImgStr homeImg:(NSString *)rImgStr
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:20]];
    [viewController.navigationItem setTitleView:label];
    
    UIImage *backImage = [UIImage imageNamed:lImgStr];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setBounds:CGRectMake(0, 0, 12, 20)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back addTarget:viewController action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    viewController.navigationItem.leftBarButtonItem = leftButton;

    UIImage *backImage2 = [UIImage imageNamed:rImgStr];
    UIButton *back2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [back2 setBounds:CGRectMake(0, 0, 18, 20)];
    [back2 setImage:backImage2 forState:UIControlStateNormal];
    [back2 addTarget:viewController action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rgtButton = [[UIBarButtonItem alloc] initWithCustomView:back2];
    [viewController.navigationItem setRightBarButtonItem:rgtButton];
    
    if (kDeviceVersion>=7.0) {
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_6"] forBarMetrics:UIBarMetricsDefault];
        [label setBackgroundColor:[UIColor clearColor]];
        [back2 setBounds:CGRectMake(0, 0, 12, 20)];
    }
}


#pragma mark - button Click
- (void)clickLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{}

@end
