//
//  BOCOPPayUtils.h
//  BOCOPPaySDK
//
//  Created by 马 天龙 on 13-1-29.
//  Copyright (c) 2013年 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOCOPPayUtils : NSObject

/**
 交易币种转换
 @param  币种
 @return 币种编码对应的中文
 */

+ (void)setURL:(NSString *)URL;

+ (NSString *)getURL;

+ (void)setASRURL:(NSString *)asrURL;

+ (NSString *)getASRURL;

+ (void)setASRLoginURL:(NSString *)asrURL;

+ (NSString *)getASRLoginURL;

+ (NSString *)convertMoneyByOriginal:(NSString *)decimalStr;

+ (NSString *)convertMoneyByOriginal:(NSString *)decimalstring integerLength:(NSInteger )Inlen;




@end
