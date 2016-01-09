//
//  HomeImgDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "HomeImgDataRequest.h"

@implementation HomeImgDataRequest

- (NSString*)getURLString
{
    return BOCOPPAY_URL_DBADLIST;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
  return BOCOPPayHttpRequestMethodPost;
}

@end
