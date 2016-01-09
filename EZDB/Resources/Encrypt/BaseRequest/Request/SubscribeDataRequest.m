//
//  SubscribeDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "SubscribeDataRequest.h"

@implementation SubscribeDataRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_SUBSCRIBE_FUND;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
