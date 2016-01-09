//
//  CFCASip.h
//  CFCASip
//
//  Created by Hong on 8/15/12.
//  Copyright (c) 2012 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AfterSipDelegator.h"

enum CFCAKeyboard {
    COMPLETE = 0,
    NUM_ONLY = 1
};

@interface CFCASip : UITextField

//密码最小长度
@property  int passwordMinLength;
//密码最大长度
@property  int passwordMaxLength;
//返回密码类型（1、hash之后加密 2、不hash加密）
@property  int outputValueType;
//密码的正则表达式
@property (nonatomic, copy) NSString *passwordRegularExpression;
//服务器端随机数，16位的byte
@property (nonatomic, copy) NSString *randomeKey_S;
//接收执行结果的代理类
@property (nonatomic, assign) id<AfterSipDelegator> sipdelegate;
//正则表达式的类型
@property (nonatomic, retain) NSRegularExpression *passwordRegex;


// 获取加密口令和随机数
- (void)getValue;

//隐藏键盘
- (void) numberKeyBoardFinish;

// 获取版本
- (NSString *)getVersion;
//设置键盘类型 0完整键盘 1 数字键盘
-(void) setCFCAKeyboardType:(enum CFCAKeyboard )keyBoardType;

- (id)init;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithCoder:(NSCoder *)aDecoder;


@end
