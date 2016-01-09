//
//  AddCardViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//
#import "BorderSetBtn.h"
#import "STViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AddCardViewController : STViewController<UITextFieldDelegate,PopViewContrlDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *avoidScrollView;
/*卡号*/
@property (weak, nonatomic) IBOutlet DBTextField *cardNoTf;
/*持卡人*/
@property (weak, nonatomic) IBOutlet DBTextField *custNameTf;
/*证件类型*/
@property (weak, nonatomic) IBOutlet DBTextField *idTypeTf;
/*手机号*/
@property (weak, nonatomic) IBOutlet DBTextField *phoneNoTf;
/*卡别名*/
@property (weak, nonatomic) IBOutlet DBTextField *cardNameTf;
/*证件号码*/
@property (weak, nonatomic) IBOutlet DBTextField *idNoTf;
/*验证码*/
@property (weak, nonatomic) IBOutlet DBTextField *codeTf;
/*确定按钮*/
@property (weak, nonatomic) IBOutlet BorderSetBtn *submitBtn;

@property (weak, nonatomic) IBOutlet UIButton *fetchCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;

@end
