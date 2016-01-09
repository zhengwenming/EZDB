//
//  BOCOPPay.h
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2013 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCOPPayModels.h"

@class BOCOPPayICardInfo;
@class BOCOPPayCFTProductSearchCriteria;
@class BOCOPPayAuthorizeView;
@interface BOCOPPay : NSObject

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *appLoginType;
@property (nonatomic, retain) BOCOPPayAuthorizeInfo *authInfo;
@property (nonatomic, retain) BOCOPPayAuthorizeView *authView;

/**
 单列模式定义
 @param  无
 @return BOCOPPay
 */
+ (BOCOPPay *)sharedInstance;                                                                           


/**
 用appley 和 appSecret 初始化
 @param  无
 @return id
 */
- (id)initWithAppKey:(NSString *)appKey
           appSecret:(NSString *)appSecrect
                 URL:(NSString *)serverUrl;

/**
 用appley 和 appSecret URL LoginType 初始化
 @param  无
 @return id
 */
- (id)initWithAppKey:(NSString *)appKey
           appSecret:(NSString *)appSecrect
        appLoginType:(NSString *)appLoginType
                 URL:(NSString *)serverUrl
              asrURL:(NSString *)asrURL;

/**
 用户登录窗口登录
 @param  无
 @return 没有返回值
 */
- (void)logIn;

/**
 注销
 @param  无
 @return 没有返回值
 */
- (void)logOut;                                                                                         

/**
 判断用户是否已经登录，logined and authorize not expired
 @param  无
 @return 没有返回值
 */
- (BOOL)isLoggedIn;                                                                                     

/**
 判断用户登录token是否过期
 @param  无
 @return 没有返回值
 */
- (BOOL)isAuthorizeExpired;                                                                             

/**
 刷新token（当用户登录token 过期后系统自动调用）
 @param  无
 @return 没有返回值
 */
- (void)refreshTokenOnSuccess:(void (^)(void))onSuccess onFail:(void (^)(NSError *error))onError;       

/**
 用户登录成功回调，opration (可不实现)
 @param  无
 @return 没有返回值
 */
- (void)onLoginSuccess:(void (^)(void))onLoginSuccess;                                                  

/**
 用户登录失败回调，opration (可不实现)
 @param  无
 @return 没有返回值
 */
- (void)onLoginFail:(void (^)(NSError *error))onLoginFail;                                              

/**
 用户退出成功回调，opration (可不实现)
 @param  无
 @return 没有返回值
 */
- (void)onLogoutSuccess:(void (^)(void))onLogoutSuccess;                                                

/**
 用户取消登录回调，opration (可不实现)
 @param  无
 @return 没有返回值
 */
- (void)onLoginCancel:(void (^)(void))onLoginCancel;                                                    

/**
 获取SDK 版本
 @param  无
 @return 没有返回值
 */
- (NSString*)getVersion;



@end