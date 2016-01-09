//
//  GetHeadImgDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "GetHeadImgDataRequest.h"

@implementation GetHeadImgDataRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_GETHEADIMG;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
