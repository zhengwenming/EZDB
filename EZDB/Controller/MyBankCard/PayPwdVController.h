//
//  PayPwdVController.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-4.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"
@class BorderSetBtn;

@interface PayPwdVController : STViewController<UITextFieldDelegate,AfterSipDelegator>

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet BorderSetBtn *submitBtn;

@property (weak, nonatomic) IBOutlet CFCASip *payPwdTf;

@property (nonatomic,retain)NSString *serverRandNum;
@property (nonatomic,retain)NSString *pdResult;
@property (nonatomic,retain)NSString *randomResult;

@end
