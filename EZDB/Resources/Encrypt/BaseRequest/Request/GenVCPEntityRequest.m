//
//  GenVCPEntityRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-4.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "GenVCPEntityRequest.h"

@implementation GenVCPEntityRequest
- (NSString*)getURLString
{
    return BOCOPPAY_URL_GENVCPENTITY;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
