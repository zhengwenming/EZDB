//
//  GetCustInfoRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "GetCustInfoRequest.h"

@implementation GetCustInfoRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_GETCUSTINFO;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
