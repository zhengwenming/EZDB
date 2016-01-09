//
//  BOCOPPayUtils.m
//  BOCOPPaySDK
//
//  Created by 马 天龙 on 13-1-29.
//  Copyright (c) 2013年 BOC. All rights reserved.
//

#import "BOCOPPayUtils.h"

@implementation BOCOPPayUtils

static NSString *url = nil;
static NSString *asrurl = nil;
static NSString *asrloginurl = nil;



+ (void)setURL:(NSString *)URL
{
    if (url==nil) {
        url = [[NSString alloc] init];
    }
    url = URL;
    [url retain];
}

+ (NSString *)getURL
{
    return url;
}
+ (void)setASRURL:(NSString *)asrURL
{
    if (asrurl==nil) {
        asrurl = [[NSString alloc] init];
    }
    asrurl = asrURL;
    [asrurl retain];
}

+ (NSString *)getASRURL
{
    return asrurl;
}

+ (void)setASRLoginURL:(NSString *)asrURL
{
    if (asrloginurl!=nil) {
        [asrloginurl release];
        asrloginurl = nil;
    }
    asrloginurl = [asrURL retain];
}

+ (NSString *)getASRLoginURL;
{
    return asrloginurl;
}

+ (NSString *)convertMoneyByOriginal:(NSString *)decimalStr
{
    NSString *temp=nil;
    NSString *resultStr=nil;
    for (int i=0;i<[decimalStr length];i++) {
        temp = [decimalStr substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"0"]) {
            continue;
        }else
        {
            resultStr =[decimalStr substringFromIndex:i];
            break;
        }
    }
    
    if (resultStr.length==0) {
        return @"0.0";
    }else{
        NSString *str = [[NSString stringWithFormat:@"%@.%@",[resultStr substringToIndex:resultStr.length-2],[resultStr substringFromIndex:resultStr.length-2]]retain];
        
        return [str autorelease];
        [str release];
    }
    
}
/**
 把9（6）v9（6）数字格式的字符串转化成double 类型的字符串
 **
 */
+ (NSString *)convertMoneyByOriginal:(NSString *)decimalstring integerLength:(NSInteger )Inlen
{
    NSString *integerMoney=[decimalstring substringToIndex:Inlen];
    NSString *decimalMoney = [decimalstring substringFromIndex:Inlen+1];
    
    NSString *integerStr=nil;
    NSString *temp=nil;
    for (int i=0; i<[integerMoney length]; i++) {
        temp = [integerMoney substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"0"]) {
            continue;
        }else
        {
            integerStr =[integerMoney substringFromIndex:i];
            break;
        }
    }
    if (integerStr.length==0) {
        integerStr=@"0";
    }
    
    NSString *decimalStr=nil;
    for (int i=0; i<[decimalMoney length]; i++) {
        temp = [decimalMoney substringWithRange:NSMakeRange(i, 1)];
        if (![temp isEqualToString:@"0"]) {
            continue;
        }else
        {
            decimalStr =[decimalMoney substringToIndex:i];
            break;
        }
    }
    if (decimalStr.length==0) {
        decimalStr=@"0";
    }
    return [NSString stringWithFormat:@"%@.%@",integerStr,decimalStr];
}


@end
