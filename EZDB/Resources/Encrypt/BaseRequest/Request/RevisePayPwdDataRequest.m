//
//  RevisePayPwdDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "RevisePayPwdDataRequest.h"

@implementation RevisePayPwdDataRequest

- (NSString*)getURLString{
    return BOCOPPAY_URL_REVISEPAYPWD;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end