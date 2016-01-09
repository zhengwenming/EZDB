//
//  ReviseLogPwdRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/24.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ReviseLogPwdRequest.h"

@implementation ReviseLogPwdRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_REVISE_PWD;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
