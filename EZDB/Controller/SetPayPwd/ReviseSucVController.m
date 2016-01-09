//
//  RiveseSucVController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ReviseSucVController.h"
#import "PerCenterVController.h"

@interface ReviseSucVController ()

@end

@implementation ReviseSucVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 
- (void)popViewContrl:(NSInteger )index
{
    if (index==1) {
        if (IS_IPHONE4) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[PerCenterVController class]]) {
                    NSLog(@"====%@",[controller class]);
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else if(IS_IPHONE5){
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[PerCenterVController class]]) {
                    NSLog(@"====%@",[controller class]);
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarWithtitle:self.titleStr superView:self.view backImg:kNavBackImgName homeImg:nil];
    
    self.sucLabel.text = self.labelStr;
    
    // Do any additional setup after loading the view from its nib.
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

@end
