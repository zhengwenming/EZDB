//
//  QueryIncomeDetailRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QueryIncomeDetailRequest.h"

@implementation QueryIncomeDetailRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_QUERYINCOMEDETAIL;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}
@end
