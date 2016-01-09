//
//  SetPayPwdViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-27.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

@class CFCASip;
@class BorderSetBtn;

@interface SetPayPwdViewController : STViewController

@property (weak, nonatomic) IBOutlet UIView *sView;

@property (weak, nonatomic) IBOutlet BorderSetBtn *submitBtn;

@property (weak, nonatomic) IBOutlet CFCASip *setPwdTextField;

@property (weak, nonatomic) IBOutlet CFCASip *confirmTextField;

@property (nonatomic,retain)NSString *serverRandNum;
@property (nonatomic,retain)NSString *pdResult;
@property (nonatomic,retain)NSString *randomResult;
@property (nonatomic,retain)NSString *pdResult2;
@property (nonatomic,retain)NSString *randomResult2;


@end
