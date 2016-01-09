//
//  RedemptionDailureController.m
//  EZDB
//
//  Created by tk on 14-11-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "RedemptionDailureController.h"
#import "ChangeCardViewController.h"


@interface RedemptionDailureController ()

@end

@implementation RedemptionDailureController

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
    [self setLine];
    [self setNav];
    [self viewDidAppear:YES];
    [self testUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
    
}
-(void)testUI
{
    _managerNumber.text=@"2014101413260001";
    _fundName.text=@"广发基金盆满钵盈";
    _tradeTime.text=@"2014.10.14 13:26";
    _tradeO.text=@"普通赎回";
    _tradeResult.text=@"成功";
    _tradeState.text=@"微信";
    _tradeMathod.text=@"中国银行 尾号2383";
    _paymont.text=@"15,000.00";
    
    
}


-(void)setNav
{
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:@"交易明细" lBtnImg:@"ico_back.png" rBtnImg:nil];
    }else{
        
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:@"交易明细" lBtnImg:@"ico_back.png" rBtnImg:nil];
        
        
    }
    self.navView.delegate = (id<PopViewContrlDelegate>)self;
    [self.view addSubview:self.navView];
}
-(void)setLine
{
    
    if (IS_IPHONE5) {
        self.changeLable.frame = CGRectMake(20, kScreenHeight-108-30, 280, 40);
        
        self.changeCardBtn.frame = CGRectMake(20, kScreenHeight-55-20, 280, 40);
    }
    else{
        if (kDeviceVersion<7.0) {
            
            self.changeLable.frame = CGRectMake(20, kScreenHeight-108, 280, 40);
            
            self.changeCardBtn.frame = CGRectMake(20, kScreenHeight-55, 280, 40);
            for (UIView *view in self.view.subviews) {
                CGRect rect = view.frame;
                rect.origin.y -= 20;
                view.frame = rect;
            }
            
        }else{
            self.changeLable.frame = CGRectMake(20, kScreenHeight-108, 280, 40);
            
            self.changeCardBtn.frame = CGRectMake(20, kScreenHeight-55, 280, 40);
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeCard:(id)sender {
    NSLog(@"sender==%@",sender);
    ChangeCardViewController * changeCardVC=[[ChangeCardViewController alloc]initWithNibName:@"ChangeCardViewController" bundle:nil];
//    跳转换卡页面需传入下列字段的值
//    changeCardVC.fundNameStr;// 基金名称
//    changeCardVC.sumMoneyStr;// 购买金额
//    changeCardVC.cardSeqStr;//  旧银行卡信息 eg:"中国银行 尾号1234"
//    changeCardVC.failOrderNo;//失败订单号
//    changeCardVC.cardSeq;//旧银行卡唯一标识
//    changeCardVC.nCardSeq;//新银行卡唯一标识
    
    if ((changeCardVC.fundNameStr.length>0)
        &&(changeCardVC.sumMoneyStr.length>0)
        &&(changeCardVC.cardSeqStr.length>0)
        &&(changeCardVC.failOrderNo.length>0)
        &&(changeCardVC.cardSeq.length>0)
        &&(changeCardVC.nCardSeq.length>0) ){
        [self.navigationController pushViewController:changeCardVC animated:YES];
        
    }
    
    [self.navigationController pushViewController:changeCardVC animated:YES];//test

}
@end