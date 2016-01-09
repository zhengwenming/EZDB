//
//  BOCOPPayRegDataRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-22.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCOPPayRegDataRequest.h"

@implementation BOCOPPayRegDataRequest

- (NSString*)getURLString{
    return BOCOPPAY_URL_CHECKTWOPASSWORD;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}

@end
