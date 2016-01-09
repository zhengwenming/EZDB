//
//  BindCardDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BindCardDataRequest.h"

@implementation BindCardDataRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_CUSTINFO;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
