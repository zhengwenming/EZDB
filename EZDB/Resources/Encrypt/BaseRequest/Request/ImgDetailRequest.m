//
//  ImgDetailRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ImgDetailRequest.h"

@implementation ImgDetailRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_DBADDETAIL;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
