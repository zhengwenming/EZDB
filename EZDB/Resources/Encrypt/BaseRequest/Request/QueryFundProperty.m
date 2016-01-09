//
//  QueryFundProperty.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-20.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QueryFundProperty.h"

@implementation QueryFundProperty
- (NSString*)getURLString
{
    return BOCOPPAY_URL_QUERYFUNDPROPERTY;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}


@end
