//
//  ChangeCardRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/20.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ChangeCardRequest.h"

@implementation ChangeCardRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_CHANGECARD;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
