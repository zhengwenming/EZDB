
#import "BOCOPLogin.h"
#import "BOCOPPayUtils.h"
#import "BOCOPPayKeychainUtils.h"
#import "BOCOPLoginConstants.h"
#import "BOCOPPayKeychainUtils.h"
#import "BOCOPPay.h"
#include "Base64Transcoder.h"
#import "QueryVCPPwdRequest.h"

@implementation BOCOPLogin

static BOCOPLogin *shareLogin;


+ (BOCOPLogin *)sharedInstance
{
    if(!shareLogin)
    {
        shareLogin = [[BOCOPLogin alloc] initWithAppKey:kAppBopKey appSecret:kAppBopSecret appLoginType:@"ASR" URL:URLLOGINBOP asrURL:BOCOPASRURL];;
    }
    return shareLogin;
}

- (NSString *)urlSchemeString
{
    return [NSString stringWithFormat:@"%@%@", kWBURLSchemePrefix, kAppBopKey];
}

- (void)logIn
{
    [self GetRandomNumData];
}
- (void)logOut
{
    [self removeAuthData];
    self.isLogin = NO;
    self.authInfo=nil;
    if (_onLogoutSuccess) {
        _onLogoutSuccess();
    }
}
- (BOOL)isBocopLogin
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

-(void)GetRandomNumData
{
    NSDictionary *headers = @{
                              @"clentid":_appKey,
                              @"userid":self.userNameField.text,
                              @"chnflg":@"1",
                              @"trandt":[MSUtil getyyyymmdd],
                              @"trantm":[MSUtil gethhmmss],
                              @"cookie":@""};

    [self.userNameField resignFirstResponder];
    [self.encryCtrl resignFirstResponder];
    
    BOCOPPayAuthorizeGetRandomNumDataRequest *request = [BOCOPPayAuthorizeGetRandomNumDataRequest requestWithHeaders:headers];

    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        self.serverRandId = result[@"randomid"] ;
        self.serverRandNum = result[@"random"] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *base64RandomCode = [self getBase64RandomCode:self.serverRandNum];
            [self startProcessSip:base64RandomCode];
        });
    }];
    [request onRequestFailWithError:^(NSError *error) {
            _onLoginFail(error);
    }];
    [request connect];

    
}
-(void)startProcessSip:(NSString *)base64RandomCode
{
        self.encryCtrl.sipdelegate = self;
        self.encryCtrl.randomeKey_S = base64RandomCode;
        [self.encryCtrl getValue];
}

#pragma mark - AfterSipDelegator
- (void)actionAfterSip:(int)resultType
        passwordResult:(NSString *)passwordResult
         randomCResult:(NSString *)randomCResult
             errorCode:(NSString *)errorCode
          errorMessage:(NSString *)errorMessage;
{
    
    if (resultType == 0) {
        if (errorCode) {
            NSDictionary *errorInfo = @{@"error_code":errorMessage,@"error_description":errorMessage};
        
            NSError *error = [[NSError alloc] initWithDomain:kBOCOPPaySDKErrorDomain
                                                         code:4
                                                     userInfo:errorInfo];
            _onLoginFail(error);
        }else{
            self.pdResult = passwordResult;
            self.randomResult = randomCResult;
            [self doLogin];
        }
    }
}

- (void)doLogin
{
    NSAssert(_appKey && [_appKey length] > 0, @"appKey is not set");
    NSAssert(_appSecret && [_appSecret length] > 0, @"appSecret is not set");
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
        NSDictionary *params = @{@"client_id":self.appKey,
                                 @"client_secret":self.appSecret,
                                 @"user_id":self.userNameField.text,
                                 @"password":self.pdResult,
                                 @"enctyp":@"0",
                                 @"state":[self getRadom],
                                 @"response_type":@"code"};
        
        BOCOPPayAuthorizeASRDataRequest *request = [BOCOPPayAuthorizeASRDataRequest requestWithParams:params];
        
        request.postJSON = [NSString stringWithFormat:@"{\"enrandom\":\"%@\",\"randomid\":\"%@\"}",self.randomResult,self.serverRandId];

        [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
                NSLog(@"parsed auth result:%@",result);
            [UserInfoSample shareInstance].userItems = result;
            BOCOPPayAuthorizeInfo *authInfo = [[BOCOPPayAuthorizeInfo alloc] init];
            authInfo.uid = result[@"uid"];
            authInfo.msgcde = result[@"msgcde"];
            authInfo.rtnmsg = result[@"rtnmsg"];
            authInfo.userId = self.userNameField.text;
            authInfo.clientId = _appKey;
            authInfo.accessToken = result[@"access_token"];
            authInfo.refreshToken = result[@"refresh_token"];
            authInfo.tokenType = result[@"tokens_type"];
            authInfo.welCome = result[@"welcome"];
            authInfo.realname = result[@"realname"];
            int expiresIn = [result[@"expires_in"] intValue];
            authInfo.expireTime = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
            authInfo.Cookie = request.Cookie;
            self.authInfo = authInfo;
            _isLogin = YES;
            _onLoginSuccess(authInfo);
        }];
        
        [request onRequestFailWithError:^(NSError *error) {
            NSLog(@"error:%@",error);
            _isLogin = NO;
            _onLoginFail(error);
        }];
        
        [request connect];
}

-(NSString *)getRadom
{
    NSInteger radom = arc4random()%10000;
    return [NSString stringWithFormat:@"%ld",(long)radom];
}

- (NSString *)getBase64RandomCode:(NSString*)randomCode{
    int length = [randomCode lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    char inputData[length];
    
    [[randomCode dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData length:length];
    size_t inputDataSize = (size_t)[randomCode length];
    size_t outputDataSize = EstimateBas64EncodedDataSize(inputDataSize);//calculate the decoded data size
    char outputData[outputDataSize];//prepare a Byte[] for the decoded data
    Base64EncodeData(inputData, inputDataSize, outputData, &outputDataSize);//decode the data
    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];//create a NSData object from the decoded data
    
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
//#warning 加release
    [theData release];
	return [base64EncodedResult autorelease];
}


- (void)readAuthorizeDataFromKeychain
{
    _authInfo = [[BOCOPPayAuthorizeInfo alloc] init];
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kKeychainServiceNameSuffix];
    _authInfo.userId = [BOCOPPayKeychainUtils getPasswordForUsername:kKeychainUserID andServiceName:serviceName error:nil];
    _authInfo.accessToken = [BOCOPPayKeychainUtils getPasswordForUsername:kKeychainAccessToken andServiceName:serviceName error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dataString = [[BOCOPPayKeychainUtils getPasswordForUsername:kKeychainExpireTime andServiceName:serviceName error:nil] substringToIndex:19];
    _authInfo.expireTime = [dateFormatter dateFromString:dataString];
//#warning 加release
    [dateFormatter release];
    _authInfo.clientId = [BOCOPPayKeychainUtils getPasswordForUsername:kKeychainClientId andServiceName:serviceName error:nil];
    _authInfo.refreshToken = [BOCOPPayKeychainUtils getPasswordForUsername:kKeychainReFreshToken andServiceName:serviceName error:nil];
}

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
        [self readAuthorizeDataFromKeychain];
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

- (void)removeAuthData
{
    [_authInfo release];
    _authInfo = nil;
    [self deleteAuthorizeDataInKeychain];
}
- (void)deleteAuthorizeDataInKeychain
{
    _authInfo.userId = nil;
    _authInfo.accessToken = nil;
    _authInfo.expireTime = nil;
    _authInfo.clientId=nil;
    _authInfo.refreshToken = nil;
    _authInfo.Cookie=nil;
    
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kWBKeychainServiceNameSuffix];
    [BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainUserID andServiceName:serviceName error:nil];
	[BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainAccessToken andServiceName:serviceName error:nil];
	[BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainExpireTime andServiceName:serviceName error:nil];
    
    [BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainClientId andServiceName:serviceName error:nil];
	[BOCOPPayKeychainUtils deleteItemForUsername:kWBKeychainReFreshToken andServiceName:serviceName error:nil];
}


#pragma mark - public methods

- (void)onLoginSuccess:(void (^)(BOCOPPayAuthorizeInfo *authorizeInfo))onLoginSuccess
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
