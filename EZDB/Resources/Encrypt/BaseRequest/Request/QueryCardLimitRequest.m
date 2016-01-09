//
//  QueryCardLimitRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QueryCardLimitRequest.h"

@implementation QueryCardLimitRequest
- (NSString*)getURLString{
    return BOCOPPAY_URL_QUERYCARDLIMIT;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
