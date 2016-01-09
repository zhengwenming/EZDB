//
//  AddSuccessViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "AddSuccessViewController.h"
#import "CardViewController.h"
@interface AddSuccessViewController ()

@end

@implementation AddSuccessViewController

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
    [self creatBarWithViewController:self navTitle:kBindCardTitle backImg:kNavBackImgName homeImg:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)submitBtn:(UIButton *)sender
{
    if (IS_IPHONE4) {
        CardViewController *cardList = [[CardViewController alloc]initWithNibName:@"CardViewController35" bundle:nil];
        [self.navigationController pushViewController:cardList animated:YES];
    }else if(IS_IPHONE5){
        CardViewController *cardList = [[CardViewController alloc]initWithNibName:@"CardViewController" bundle:nil];
        [self.navigationController pushViewController:cardList animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
