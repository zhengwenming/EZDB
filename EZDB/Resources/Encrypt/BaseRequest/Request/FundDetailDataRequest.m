//
//  FundDetailDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "FundDetailDataRequest.h"

@implementation FundDetailDataRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_FUNDDETAIL;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
