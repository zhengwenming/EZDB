//
//  DbNoticeListRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-1.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "DbNoticeListRequest.h"

@implementation DbNoticeListRequest
- (NSString*)getURLString
{
    return BOCOPPAY_URL_DBNOTICE_LIST;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}
@end
