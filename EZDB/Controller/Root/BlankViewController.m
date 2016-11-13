//
//  BlankViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BlankViewController.h"

#import "AssetViewController.h"
#import "ProfitListController.h"
#import "TransactionListController.h"
#import "PopMenu.h"
#import "BankView.h"



@interface BlankViewController ()
{
    UIViewController *currentViewController;
    
}
@end

@implementation BlankViewController

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
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index==2){
        NSArray *menuItems =
        @[
          
          [MenuItem menuItem:@"我的资产"
                       image:[UIImage imageNamed:@"ico_mymoney.png"]
                      target:self
                      action:@selector(pushMenuItem:)],
          
          [MenuItem menuItem:@"收益明细"
                       image:[UIImage imageNamed:@"ico_profit.png"]
                      target:self
                      action:@selector(pushMenuItem:)],
          
          [MenuItem menuItem:@"交易明细"
                       image:[UIImage imageNamed:@"ico_transaction.png"]
                      target:self
                      action:@selector(pushMenuItem:)],
          
          ];
        
        if (kDeviceVersion>=7.0) {
            [PopMenu showMenuInView:self.view
                           fromRect:CGRectMake(280, 23, 20, 30)
                          menuItems:menuItems];
            
        }else{
            [PopMenu showMenuInView:self.view
                           fromRect:CGRectMake(280, 23-20, 20, 30)
                          menuItems:menuItems];
            
        }
        
    }
}

#pragma mark 收益明细＋交易明细
- (void) pushMenuItem:(id)sender
{
    
    AssetViewController *assetVC = [self.childViewControllers objectAtIndex:0];
    assetVC.navigationController.navigationBarHidden = YES;
    
    ProfitListController *profitVC = [self.childViewControllers objectAtIndex:1];
    TransactionListController *transactionVC = [self.childViewControllers objectAtIndex:2];
    
    MenuItem *item = (MenuItem *)sender;
    NSLog(@"%@", item.title);
    self.navView.titleView.titleLabel.text = item.title;
    
    UIViewController *oldViewController = currentViewController;
    
    if((currentViewController == assetVC && [[item title]isEqualToString:@"我的资产"]) || (currentViewController == profitVC && [[item title]isEqualToString:@"收益明细"]) || (currentViewController== transactionVC && [[item title]isEqualToString:@"交易明细"]))
    {
        return;
    }
    
    if ([item.title isEqualToString:@"我的资产"]) {
        [self transitionFromViewController:currentViewController toViewController:assetVC duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        }  completion:^(BOOL finished) {
            if (finished) {
                currentViewController=assetVC;
            }else{
                currentViewController=oldViewController;
            }}];
        
    }else if ([item.title isEqualToString:@"收益明细"]){
        [self transitionFromViewController:currentViewController toViewController:profitVC duration:0.6 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        }  completion:^(BOOL finished) {
            if (finished) {
                currentViewController=profitVC;
            }else{
                currentViewController=oldViewController;
            }}];
        
    }else if([item.title isEqualToString:@"交易明细"]){
        [self transitionFromViewController:currentViewController toViewController:transactionVC duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        }  completion:^(BOOL finished) {
            if (finished) {
                currentViewController=transactionVC;
            }else{
                currentViewController=oldViewController;
            }}];
    }
    [self.view bringSubviewToFront:self.navView];
}


-(void)initNav{
    
    
    
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:@"我的资产" lBtnImg:nil rBtnImg:@"ico_ddd.png"];
        AssetViewController *assetVC = [[AssetViewController alloc]init];
        assetVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
        [self addChildViewController:assetVC];
        
        ProfitListController *profitVC = [[ProfitListController alloc]init];
        profitVC.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
        [self addChildViewController:profitVC];
        
        TransactionListController *transactionVC = [[TransactionListController alloc]init];
        transactionVC.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
        [self addChildViewController:transactionVC];
        [self.view addSubview:assetVC.view];
        currentViewController = assetVC;
        
    }else{
        
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:@"我的资产" lBtnImg:nil rBtnImg:@"ico_ddd.png"];
        AssetViewController *assetVC = [[AssetViewController alloc]init];
        assetVC.view.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
        [self addChildViewController:assetVC];
        
        ProfitListController *profitVC = [[ProfitListController alloc]init];
        profitVC.view.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
        [self addChildViewController:profitVC];
        
        TransactionListController *transactionVC = [[TransactionListController alloc]init];
        transactionVC.view.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
        [self addChildViewController:transactionVC];
        [self.view addSubview:assetVC.view];
        currentViewController = assetVC;
    }
   
    self.navView.delegate = (id<PopViewContrlDelegate>)self;
    [self.view addSubview:self.navView];
    [self.view bringSubviewToFront:self.navView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
    self.view.backgroundColor = [UIColor clearColor];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
