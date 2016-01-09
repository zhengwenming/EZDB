//
//  QureyHistoryDetailRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QureyHistoryDetailRequest.h"

@implementation QureyHistoryDetailRequest
- (NSString*)getURLString
{
    return BOCOPPAY_URL_QUERYHISTORYDETAIL;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}
@end
