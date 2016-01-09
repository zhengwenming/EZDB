//
//  UpdPwdViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-28.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFCASip;
@class BorderSetBtn;

@interface UpdPwdViewController : STViewController<AfterSipDelegator,PopViewContrlDelegate>

@property (weak, nonatomic) IBOutlet UIView *sVIew;

@property (weak, nonatomic) IBOutlet UIButton *fBtn;

@property (weak, nonatomic) IBOutlet BorderSetBtn *submitBtn;

@property (weak, nonatomic) IBOutlet CFCASip *oldPwdTextField;

@property (weak, nonatomic) IBOutlet CFCASip *pwdTextfield;

@property (weak, nonatomic) IBOutlet CFCASip *pwdAgainTextField;


@property (nonatomic,retain)NSString *serverRandNum;
@property (nonatomic,retain)NSString *pdResult;
@property (nonatomic,retain)NSString *randomResult;
@property (nonatomic,retain)NSString *pdResult2;
@property (nonatomic,retain)NSString *randomResult2;
@property (nonatomic,retain)NSString *pdResult3;
@property (nonatomic,retain)NSString *randomResult3;

@end
