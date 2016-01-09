//
//  ResetPwdVController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"
#import "BorderSetLabel.h"

@class BorderSetLabel;

@interface ResetPwdVController : STViewController

@property (weak, nonatomic) IBOutlet CFCASip *nPwdTF;

@property (weak, nonatomic) IBOutlet CFCASip *confirmPwdTF;

@property (weak, nonatomic) IBOutlet DBTextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *fetchCodeBtn;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@property (nonatomic,retain)NSString *serverRandNum;
@property (nonatomic,retain)NSString *pdResult;
@property (nonatomic,retain)NSString *randomResult;
@property (nonatomic,retain)NSString *pdResult2;
@property (nonatomic,retain)NSString *randomResult2;

@end
