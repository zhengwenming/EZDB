//
//  QueryHistoryListRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QueryHistoryListRequest.h"

@implementation QueryHistoryListRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_QUERYHISTORYLIST;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}
@end
