//
//  redeemPasswordViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"
//赎回时 输入支付密码页面

@interface redeemPasswordViewController : STViewController
- (IBAction)submitAction:(id)sender;
- (IBAction)forgetPasswordAction:(id)sender;
@property (weak, nonatomic) IBOutlet CFCASip *passwordTF;

//请求用
@property (nonatomic,retain)NSString *serverRandNumRedeem;
@property (nonatomic,retain)NSString *pdResultRedeem;
@property (nonatomic,retain)NSString *randomResultRedeem;

//传值用
@property (nonatomic,retain)NSString * cardSeqStr;//银行卡唯一标识
@property (nonatomic,retain)NSString * fundCodeStr;//基金代码
@property (nonatomic,retain)NSString * redeemTypeStr;//赎回类型
@property (nonatomic,retain)NSString * redeemShare;//赎回份额
@end
