//
//  SubscribeResultRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "SubscribeResultRequest.h"

@implementation SubscribeResultRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_SUBSCRIBE_REUSULT;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
