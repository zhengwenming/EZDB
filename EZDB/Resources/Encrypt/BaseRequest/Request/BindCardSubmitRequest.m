//
//  BindCardSubmitRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BindCardSubmitRequest.h"

@implementation BindCardSubmitRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_BINDSUBMIT;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
