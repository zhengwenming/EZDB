//
//  NSString+EncodingUTF8Additions.m
//  头版
//
//  Created by yeby on 14-6-26.
//  Copyright (c) 2014年 Yuninfo. All rights reserved.
//

#import "NSString+EncodingUTF8Additions.h"

@implementation NSString (EncodingUTF8Additions)


-(NSString *)URLEncodingUTF8String{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
    return result;
}
-(NSString *)URLDecodingUTF8String{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(""),
                                                                                           kCFStringEncodingUTF8));
    
    return result;
}

@end
