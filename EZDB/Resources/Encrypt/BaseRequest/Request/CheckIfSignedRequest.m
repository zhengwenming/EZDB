//
//  CheckIfSignedRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/24.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "CheckIfSignedRequest.h"

@implementation CheckIfSignedRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_FUND_IF_SIGNED;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
