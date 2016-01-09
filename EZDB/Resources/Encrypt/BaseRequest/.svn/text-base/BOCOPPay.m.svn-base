//
//  BOCOPPay.m
//
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2013 BOC. All rights reserved.
//

#import "BOCOPPay.h"
#import "BOCOPPayDataRequest.h"
#import "BOCOPPayAuthorizeView.h"
#import "BOCOPPayAuthorizeInfo.h"
#import "BOCOPPayKeychainUtils.h"
#import "BOCOPPayAuthorizeDataRequest.h"

#import "BOCOPPayAuthorizeGetRandomNumDataRequest.h"
#import "BOCOPPayDebug.h"

#import "BOCOPPayObjectSingleton.h"

#import "BOCOPPayRefreshTokenDataRequest.h"

@interface BOCOPPay (){
    void (^_onLoginSuccess)(void);
    void (^_onLoginFail)(NSError *);
    void (^_onLogoutSuccess)(void);
    void (^_onLoginCancel)(void);
    
}
@end

#define kWBURLSchemePrefix              @"BOCOPPay_"

#define kWBKeychainServiceNameSuffix    @"_BOCOPPayServiceName"
#define kWBKeychainUserID               @"BOCOPPayUserID"
#define kWBKeychainAccessToken          @"BOCOPPayAccessToken"
#define kWBKeychainExpireTime           @"BOCOPPayExpireTime"

#define kWBKeychainReFreshToken         @"BOCOPPayReFreshToken"
#define kWBKeychainClientId             @"BOCOPPayClientId"

@interface BOCOPPay (Private)

- (NSString *)urlSchemeString;

- (void)saveAuthorizeDataToKeychain;
- (void)readAuthorizeDataFromKeychain;
- (void)deleteAuthorizeDataInKeychain;

@end

@implementation BOCOPPay
BOCOPOBJECT_SINGLETON_BOILERPLATE(BOCOPPay, sharedInstance)
#pragma mark - lifecycle methods

#pragma mark - WBEngine Private Methods

- (NSString *)urlSchemeString
{
    return [NSString stringWithFormat:@"%@%@", kWBURLSchemePrefix, _appKey];
}

- (void)saveAuthorizeDataToKeychain
{
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kWBKeychainServiceNameSuffix];
    [BOCOPPayKeychainUtils storeUsername:kWBKeychainUserID andPassword:_authInfo.userId forServiceName:serviceName updateExisting:YES error:nil];
	[BOCOPPayKeychainUtils storeUsername:kWBKeychainAccessToken andPassword:_authInfo.accessToken forServiceName:serviceName updateExisting:YES error:nil];
    
    BOCOPDINFO(@"过期日期：%@",_authInfo.expireTime);
    
	[BOCOPPayKeychainUtils storeUsername:kWBKeychainExpireTime andPassword:[NSString stringWithFormat:@"%@", _authInfo.expireTime] forServiceName:serviceName updateExisting:YES error:nil];
    
    [BOCOPPayKeychainUtils storeUsername:kWBKeychainReFreshToken andPassword:[NSString stringWithFormat:@"%@", _authInfo.refreshToken] forServiceName:serviceName updateExisting:YES error:nil];
    
    [BOCOPPayKeychainUtils storeUsername:kWBKeychainClientId andPassword:[NSString stringWithFormat:@"%@", _authInfo.clientId] forServiceName:serviceName updateExisting:YES error:nil];
}

- (void)readAuthorizeDataFromKeychain
{
    _authInfo = [[BOCOPPayAuthorizeInfo alloc] init];
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kWBKeychainServiceNameSuffix];
    _authInfo.userId = [BOCOPPayKeychainUtils getPasswordForUsername:kWBKeychainUserID andServiceName:serviceName error:nil];
    _authInfo.accessToken = [BOCOPPayKeychainUtils getPasswordForUsername:kWBKeychainAccessToken andServiceName:serviceName error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dataString = [[BOCOPPayKeychainUtils getPasswordForUsername:kWBKeychainExpireTime andServiceName:serviceName error:nil] substringToIndex:19];
    _authInfo.expireTime = [dateFormatter dateFromString:dataString];
    
    _authInfo.clientId = [BOCOPPayKeychainUtils getPasswordForUsername:kWBKeychainClientId andServiceName:serviceName error:nil];
    _authInfo.refreshToken = [BOCOPPayKeychainUtils getPasswordForUsername:kWBKeychainReFreshToken andServiceName:serviceName error:nil];
    [dateFormatter release];
}

- (void)deleteAuthorizeDataInKeychain
{
    _authInfo.userId = nil;
    _authInfo.accessToken = nil;
    _authInfo.expireTime = nil;
    _authInfo.clientId=nil;
    _authInfo.refreshToken = nil;
    
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kWBKeychainServiceNameSuffix];
    [BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainUserID andServiceName:serviceName error:nil];
	[BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainAccessToken andServiceName:serviceName error:nil];
	[BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainExpireTime andServiceName:serviceName error:nil];
    
    [BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainClientId andServiceName:serviceName error:nil];
	[BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainReFreshToken andServiceName:serviceName error:nil];
}

- (void)dealloc
{
    [_onLoginSuccess release];
    [_onLoginFail release];
    [_onLogoutSuccess release];
    [_onLoginCancel release];

    [_appKey release];
    [_appSecret release];
    [_authInfo release];
    
    [super dealloc];
}
/**
 * @description 程序接口初始化 一期
 */
- (id)initWithAppKey:(NSString *)appKey
           appSecret:(NSString *)appSecrect
                 URL:(NSString *)serverUrl
{
    if ((self = [super init]))
    {
        self.appKey = appKey;
        self.appSecret = appSecrect;
        
        [self readAuthorizeDataFromKeychain];
        BOCOPDINFO(@"%@",_authInfo.userId);
        
        if (serverUrl) {
            [BOCOPPayUtils setURL:serverUrl];
        }
    }
    return self;
}

/**
 * @description 程序接口初始化 二期ASR
 */
- (id)initWithAppKey:(NSString *)appKey
           appSecret:(NSString *)appSecrect
        appLoginType:(NSString *)appLoginType
                 URL:(NSString *)serverUrl
              asrURL:(NSString *)asrURL
{
    if ((self = [super init]))
    {
        self.appKey = appKey;
        self.appSecret = appSecrect;
        self.appLoginType = appLoginType;
        
        [self readAuthorizeDataFromKeychain];
        BOCOPDINFO(@"%@",_authInfo.userId);
        
        if (serverUrl) {
            [BOCOPPayUtils setURL:serverUrl];
        }
        if ([appLoginType isEqualToString:@"ASR"] && asrURL) {
            [BOCOPPayUtils setASRURL:asrURL];
        }
    }
    return self;
}

#pragma mark - private methods
/**
 * @description 清空认证信息
 */
- (void)removeAuthData
{
    [_authInfo release];
    _authInfo = nil;
    [self deleteAuthorizeDataInKeychain];
}

- (void)loginDidFailWithError:(NSError *)error
{
    if (_onLoginFail) {
        BOCOPDINFO(@"_onLoginFail is called:%@",error);
        _onLoginFail(error);
    }
}

- (NSDictionary*)getBusinessRequestHeaderDictionary
{
    
    return @{@"cictid":@"liuheping",@"clentid":_authInfo.clientId,@"userid":_authInfo.userId,@"acton":_authInfo.accessToken,@"chnflg":@"1",@"trandt":@"20130125",@"trantm":@"153059",@"trano":@"2222222"};
}

#pragma mark - test methods
- (void)checkLoginStateOnComplete:(void (^)(void))onComplete
                          onError:(void (^)(NSError *error))onError{
    if (!_authInfo || ![_authInfo isLogined]) {
        // not logined,show login dialog
        BOCOPDINFO(@"需要登录");
        //[self logIn];
    }else if([_authInfo isAuthorizeExpired]){
        // is expired , should refresh token
        [self refreshTokenOnSuccess:^{
            onComplete();
        }
                             onFail:^(NSError *error) {
                                 NSDictionary *errorInfo = @{@"error_description":@"获取refresh token失败"};
                                 NSError *err = [[[NSError alloc] initWithDomain:kBOCOPPaySDKErrorDomain
                                                                    code:BOCOPPaySDKErrorCodeAuthRefreshFailed
                                                                userInfo:errorInfo] autorelease];
                                 onError(err);
                             }];
    }else{
        onComplete();
    }
}

#pragma mark - public methods

- (BOOL)isLoggedIn
{
    if (_authInfo) {
        return ([_authInfo isLogined] && ![_authInfo isAuthorizeExpired]);
    }
    return NO;
}

- (BOOL)isAuthorizeExpired
{
    if (_authInfo && [_authInfo isLogined]) {
        return [_authInfo isAuthorizeExpired];
    }
    return YES;
}

- (void)logIn
{
    if ([self isLoggedIn] && _onLoginSuccess) {
        
        BOCOPDINFO(@"_onLoginSuccess is called");
        _onLoginSuccess();
        return;
    }
    if (self.authView!=nil && self.authView._isShowing) {
        return;
    }
    self.authView = [BOCOPPayAuthorizeView viewFromNib];
    [self.authView setAppKey:self.appKey appSecret:self.appSecret appLoginType:self.appLoginType];
    
    [self.authView onLoginSuccess:^(BOCOPPayAuthorizeInfo *authorizeInfo){
        BOCOPDINFO(@"onLoginSuccess:%@",authorizeInfo);
        [_authInfo release];
        _authInfo = nil;
        _authInfo = [authorizeInfo retain];
        
        [self saveAuthorizeDataToKeychain];
        
        if (_onLoginSuccess) {
            BOCOPDINFO(@"_onLoginSuccess is called");
            _onLoginSuccess();
        }
    }];
    
    [self.authView onLoginCancel:^{
        if (_onLoginCancel) {
            BOCOPDINFO(@"_onLoginCancel is called");
            _onLoginCancel();
        }
    }];
    [self.authView onLoginFail:^(NSError *error) {
        [self loginDidFailWithError:error];
        
    }];
    [self.authView show];
}

- (void)logOut
{
    [self removeAuthData];
//    self.authInfo.Cookie=@"";
    self.authInfo=nil;
    if (_onLogoutSuccess) {
        _onLogoutSuccess();
    }
}

- (NSString*)getVersion
{
    return BOCOPPaySDKVersion;
}

- (void)refreshTokenOnSuccess:(void (^)(void))onSuccess onFail:(void (^)(NSError *error))onError
{
    NSAssert(_appKey && [_appKey length] > 0, @"appKey is not set");
    NSAssert(_appSecret && [_appSecret length] > 0, @"appSecret is not set");
    
    if (!_authInfo || ![_authInfo isLogined]) {
        return;
    }
    if (![_authInfo isAuthorizeExpired]) {
        BOCOPDINFO(@"refresh anyway only for debug");
        //return;
    }
    
    NSDictionary *params = @{@"client_id":_appKey,@"client_secret":_appSecret,@"grant_type":@"refresh_token",@"refresh_token":_authInfo.refreshToken};
    
    BOCOPDINFO(@"params:%@",params);
    BOCOPPayRefreshTokenDataRequest *request = [BOCOPPayRefreshTokenDataRequest requestWithParams:params];
    
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        BOCOPDINFO(@"parsed auth result:%@",result);
        _authInfo.accessToken = result[@"access_token"];
        
        _authInfo.refreshToken = result[@"refresh_token"];
        
        _authInfo.tokenType = result[@"token_type"];
        int expiresIn = [result[@"expires_in"] intValue];
        _authInfo.expireTime = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
        
        onSuccess();
    }];
    
    [request onRequestFailWithError:^(NSError *error) {
        onError(error);
    }];
    
    [request connect];
}
#pragma mark - public methods

- (void)onLoginSuccess:(void (^)(void))onLoginSuccess
{
    [_onLoginSuccess release];
    _onLoginSuccess = nil;
    _onLoginSuccess = [onLoginSuccess copy];
}

- (void)onLoginFail:(void (^)(NSError *error))onLoginFail
{
    [_onLoginFail release];
    _onLoginFail = nil;
    _onLoginFail = [onLoginFail copy];
    
    
    
}

- (void)onLogoutSuccess:(void (^)(void))onLogoutSuccess
{
    [_onLogoutSuccess release];
    _onLogoutSuccess = nil;
    _onLogoutSuccess = [onLogoutSuccess copy];
}

- (void)onLoginCancel:(void (^)(void))onLoginCancel
{
    [_onLoginCancel release];
    _onLoginCancel = nil;
    _onLoginCancel = [onLoginCancel copy];
}



@end
