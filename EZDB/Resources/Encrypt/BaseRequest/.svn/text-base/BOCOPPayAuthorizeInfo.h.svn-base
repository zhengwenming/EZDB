//
//  Car.h
//  iTotemFrame
//
//  Created by Rainbow Zhang on 12/27/11.
//  Copyright (c) 2011 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCOPPayBaseModelObject.h"

@interface BOCOPPayAuthorizeInfo : BOCOPPayBaseModelObject

/** //用户ID */
@property (nonatomic, retain)NSString *userId;                  

/** //uid */
@property (nonatomic, retain)NSString *uid;

/** clientId */
@property (nonatomic, retain)NSString *clientId;                

/** accessToken */
@property (nonatomic, retain)NSString *accessToken;             

/** refreshToken */
@property (nonatomic, retain)NSString *refreshToken;            

/**  过期时间 */
@property (nonatomic, retain)NSDate *expireTime;

/**  令牌 */
@property (nonatomic, retain)NSString *tokenType;

/**  欢迎词 */
@property (nonatomic, retain)NSString *welCome;

/**  用户资料完整情况 */
@property (nonatomic, retain)NSString *ismsgfull;

/**  是否需要补登纪录 */
@property (nonatomic, retain)NSString *Cookie;

/** 实名制客户标识 */
@property (nonatomic, retain)NSString *realname;

@property (nonatomic, retain)NSString *msgcde;

@property (nonatomic, retain)NSString *rtnmsg;

/**
 
 是否已经登录
 @param  无
 @return BOOL
 */
- (BOOL)isLogined;

/**
 是否过期
 @param  无
 @return BOOL
 */
- (BOOL)isAuthorizeExpired;

@end
