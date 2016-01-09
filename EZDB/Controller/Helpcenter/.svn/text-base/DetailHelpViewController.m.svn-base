//
//  DetailHelpViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "DetailHelpViewController.h"

@interface DetailHelpViewController ()

@end

@implementation DetailHelpViewController

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

    [self setNavBarWithtitle:kHelpCenterTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
    if (kDeviceVersion>=7.0) {
        //titleLabel
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 170, 40)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.titleLabel.text = self.titleString;
        [self.view addSubview:self.titleLabel];
        
        //bottomLabel
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-80+10, kScreenWidth, 40)];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textColor = [UIColor lightGrayColor];
        self.bottomLabel.font = [UIFont systemFontOfSize:8.0];
        
        self.bottomLabel.text = @"尊敬的用户，常见问题解答如还是未能解决您的疑问，欢迎拨打客户服务专线";
        [self.view addSubview:self.bottomLabel];
        
        //phoneLabel
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-80+40, kScreenWidth, 40)];
        phoneLabel.textColor = [UIColor lightGrayColor];
        phoneLabel.tag = 888;
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.font = [UIFont systemFontOfSize:16.0];
        phoneLabel.textColor = [UIColor redColor];
        phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callTelephone:)];
        [phoneLabel addGestureRecognizer:phoneTap];
        phoneLabel.text = @"4001096998";
        [self.view addSubview:phoneLabel];
    }else{
        //titleLabel
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, 170, 40)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.titleLabel.backgroundColor = self.view.backgroundColor;
        self.titleLabel.text = self.titleString;
        [self.view addSubview:self.titleLabel];

        //bottomLabel
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-40-80+39, kScreenWidth, 30)];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textColor = [UIColor lightGrayColor];
        self.bottomLabel.font = [UIFont systemFontOfSize:8.0];
        self.bottomLabel.text = @"尊敬的用户，常见问题解答如还是未能解决您的疑问，欢迎拨打客户服务专线";
        [self.view addSubview:self.bottomLabel];
        
         //phoneLabel
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bottomLabel.frame.origin.x, self.bottomLabel.frame.origin.y+self.bottomLabel.frame.size.height, kScreenWidth, 30)];
        phoneLabel.tag = 888;
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.font = [UIFont systemFontOfSize:16.0];
        phoneLabel.textColor = [UIColor redColor];
        phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callTelephone:)];
        [phoneLabel addGestureRecognizer:phoneTap];
        phoneLabel.text = @"4001096998";
        [self.view addSubview:phoneLabel];
        
    }
}
- (void)callTelephone:(UITapGestureRecognizer *)sender
{
    UILabel *phoneLabel = (UILabel *)[self.view viewWithTag:888];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneLabel.text]]];
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
