//
//  BOCOLogoutRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-5.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCOLogoutRequest.h"

@implementation BOCOLogoutRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_LOGOUT;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodDelete;
}

@end
