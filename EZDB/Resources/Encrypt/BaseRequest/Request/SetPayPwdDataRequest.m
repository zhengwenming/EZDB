//
//  SetPayPwdDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "SetPayPwdDataRequest.h"

@implementation SetPayPwdDataRequest

- (NSString*)getURLString{
    return BOCOPPAY_URL_SETPAYPWD;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
