//
//  GetServerRandomRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "GetServerRandomRequest.h"

@implementation GetServerRandomRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_GET_SERVER_RANDOM;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}


@end
