//
//  LoginViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-14.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BorderSetBtn;
@interface LoginViewController : STViewController<AfterSipDelegator,
                                                UITextFieldDelegate,
                                                PopViewContrlDelegate>

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet DBTextField *bInputYouUserName;
@property (weak, nonatomic) IBOutlet CFCASip *bInputYouPassword;
@property (weak, nonatomic) IBOutlet BorderSetBtn *loginBtn;
@property (weak, nonatomic) IBOutlet BorderSetBtn *regBtn;
@property (weak, nonatomic) IBOutlet UIButton *remBtn;
@property (strong ,nonatomic) DBTitleView *titleView;

@end
