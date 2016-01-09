//
//  Car.m
//  iTotemFrame
//
//  Created by Rainbow Zhang on 12/27/11.
//  Copyright (c) 2011 iTotemStudio. All rights reserved.
//

#import "BOCOPPayAuthorizeInfo.h"
#import "BOCOPPayDebug.h"


@implementation BOCOPPayAuthorizeInfo

- (void)dealloc
{
    [_userId release];
    [_realname release];
    [_accessToken release];
    [_refreshToken release];
    [_expireTime release];
    [_clientId release];
    [_tokenType release];
    [_welCome release];
    [_ismsgfull release];
    [_Cookie release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


/**
    Key-Value pair by dictionary key name and property name.
    key:    dictionary key name
    value:  property name
 **/
- (NSDictionary*)attributeMapDictionary
{
	return @{@"userId": @"userId"
            ,@"clientId": @"clientId"
            ,@"accessToken": @"accessToken"
            ,@"refreshToken": @"refreshToken"
            ,@"expireTime": @"expireTime"
            ,@"tokenType": @"token_type"
            ,@"welCome": @"welcome"
            ,@"ismsgfull":@"ismsgfull"
            ,@"realname":@"realname"};
}


- (BOOL)isLogined
{
    BOCOPDINFO(@"登录信息%@%@%@",_userId,_accessToken,_expireTime);
    return (_userId && _accessToken && _expireTime);
}

- (BOOL)isAuthorizeExpired
{
    NSDate *now =  [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    //NSString *localTimeStr = [formatter stringFromDate:now];
    BOCOPDINFO(@"now [%@]",now);
    [formatter release];
    BOCOPDINFO(@"expireTime:[%@]",_expireTime);
    if ([_expireTime earlierDate:now] == _expireTime) {
        BOCOPDINFO(@"authorize is expired");
        return YES;
    }else{
        BOCOPDINFO(@"authorize is not expired");
        return NO;
    }
}


@end
