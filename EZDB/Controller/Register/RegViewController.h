//
//  RegViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BorderSetBtn;

@interface RegViewController : STViewController<UITextFieldDelegate,AfterSipDelegator,ASIHTTPRequestDelegate>


@property (weak, nonatomic) IBOutlet DBTextField *userNameTF;
@property (weak, nonatomic) IBOutlet CFCASip *pwdTF;
@property (weak, nonatomic) IBOutlet CFCASip *pwdAgainTF;
@property (weak, nonatomic) IBOutlet BorderSetBtn *registerButton;
@property (weak, nonatomic) IBOutlet BorderSetBtn *directLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;
@property (weak, nonatomic) IBOutlet UIImageView *popIV;
@property (weak, nonatomic) IBOutlet UILabel *popLabel;

@property (nonatomic,retain)NSString *serverRandId;
@property (nonatomic,retain)NSString *serverRandNum;
@property (nonatomic,retain)NSString *serverRandId2;
@property (nonatomic,retain)NSString *serverRandNum2;
@property (nonatomic,retain)NSString *pdResult;
@property (nonatomic,retain)NSString *randomResult;
@property (nonatomic,retain)NSString *pdResult2;
@property (nonatomic,retain)NSString *randomResult2;


@end
