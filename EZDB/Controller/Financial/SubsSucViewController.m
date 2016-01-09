//
//  SubsSucViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/25.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "SubsSucViewController.h"
#import "FinacialViewController.h"

#define kFinishViewRect CGRectMake(137, 91, 44, 44)
#define kConLabelRect   CGRectMake(70, 144, 251,32)
#define kLineViewRect   CGRectMake(0, 183, 320,  1)
#define kLineDotRect    CGRectMake(32, 193, 16,136)
#define kConLabelText   @"恭喜您，申购成功!"


@interface SubsSucViewController ()

@end

@implementation SubsSucViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSubviews];
    // Do any additional setup after loading the view.
}

- (void)setUpSubviews
{
    [self setNavBarWithtitle:kPurchaseTitle superView:
     self.view backImg:kNavBackImgName homeImg:nil];
    [self.moneyLabel setText:self.tranMoney];
    [self.dateLabel setText:self.tranDate];
    [self.profitDate setText:self.profitStart];
    [self.profitGetLabel setText:self.profitReach];

#if 0
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:kFinishViewRect];
    [imgView setImage:[UIImage imageNamed:@"finish.png"]];
    [imgView setAutoresizesSubviews:YES];
    
    UILabel *conLabel = [[UILabel alloc]initWithFrame:kConLabelRect];
    [conLabel setText:kConLabelText];
    [conLabel setTextColor:kBLueColor];
    [conLabel setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *changeLine = [[UIImageView alloc]initWithFrame:kLineViewRect];
    [changeLine setImage:[UIImage imageNamed:@"line_change.png"]];

    UIImageView *dotLine = [[UIImageView alloc]initWithFrame:kLineDotRect];
    [dotLine setImage:[UIImage imageNamed:@"line_dot"]];
    
    [self.view addSubview:imgView];
    [self.view addSubview:conLabel];
    [self.view addSubview:changeLine];
    [self.view addSubview:dotLine];
#endif
}

#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    if (index==1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[FinacialViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
