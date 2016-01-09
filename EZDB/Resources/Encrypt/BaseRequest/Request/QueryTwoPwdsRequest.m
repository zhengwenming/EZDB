//
//  QueryTwoPwdsRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/24.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QueryTwoPwdsRequest.h"

@implementation QueryTwoPwdsRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_QUERY_TWO_PWDS;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
