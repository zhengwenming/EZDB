//
//  DbNoticeDetailRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "DbNoticeDetailRequest.h"

@implementation DbNoticeDetailRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_DBNOTICE_DETAIL;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
