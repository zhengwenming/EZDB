//
//  BindGetCodeRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BindGetCodeRequest.h"

@implementation BindGetCodeRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_GETCODE;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
