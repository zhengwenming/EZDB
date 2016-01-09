//
//  RedeemResultRequestr.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/24.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "RedeemResultRequestr.h"

@implementation RedeemResultRequestr
- (NSString*)getURLString
{
    return BOCOPPAY_URL_QUERY_REDEEM_RESULT;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}
@end
