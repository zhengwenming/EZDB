//
//  UploadAvatarRequest.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "UploadAvatarRequest.h"
//
@implementation UploadAvatarRequest
- (NSString*)getURLString
{
    return UPLOAD_URL;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPost;
}
@end
