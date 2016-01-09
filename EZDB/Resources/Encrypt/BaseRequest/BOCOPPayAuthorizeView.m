//
//  BOCPayAuthorizeView.m
//
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import "BOCOPPayAuthorizeView.h"
#import <QuartzCore/QuartzCore.h>
#import "CFCASip.h"
#import "BOCOPPayDataRequest.h"
#import "AfterSipDelegator.h"
#import "BOCOPPayAuthorizeDataRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "BOCOPPayAuthorizeGetRandomNumDataRequest.h"
#import "BOCOPPayDebug.h"
#include "Base64Transcoder.h"
#import "BOCOPPayRequestManager.h"
#import "BOCOPPayAuthorizeASRDataRequest.h"

#define USE_SIP NO

#define CANUSECHARACTER @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@_."

typedef enum:int {
    BOCOPPayAuthorizeViewAlertTypeEmptyUserName = 1,
    BOCOPPayAuthorizeViewAlertTypeMalformPassword = 2
} BOCOPPayAuthorizeViewAlertType;

@interface BOCOPPayAuthorizeView()
{
    CFCASip *_passwordField;
    NSString *_appKey;
    NSString *_appSecret;
    NSString *_appLoginType;
    NSString *_uid;
    NSString *_password;
    NSString *_randCode;
    
    NSString *_serverRandId;
    NSString *_serverRandNum;
    void (^_onLoginSuccess)(BOCOPPayAuthorizeInfo *);
    void (^_onLoginFail)(NSError *);
    void (^_onLoginCancel)(void);
    BOOL _isLogging;
    
    UIView *bgView;
    
}
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (retain, nonatomic) IBOutlet UIView *sipPositionView;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@end

@implementation BOCOPPayAuthorizeView

#pragma mark - lifecycle methods

- (void)dealloc
{
    [_serverRandId release];
    [_serverRandNum release];
    [_appKey release];
    [_appSecret release];
    [_uid release];
    [_password release];
    [_randCode release];
    [_userNameTextField release];
    [_sipPositionView release];
    [_passwordField release];
    [_onLoginSuccess release];
    [_onLoginFail release];
    [_onLoginCancel release];
    [_loadingIndicator release];
    [super dealloc];
}

+ (BOCOPPayAuthorizeView*)viewFromNib
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BOCOPPayAuthorizeView" owner:nil options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_userNameTextField setDelegate:self];
    [self setupSipView];
}

#pragma mark - private methods

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
    [theData release];
	return [base64EncodedResult autorelease];
}

- (void)showLoading
{
    [_loadingIndicator startAnimating];
}

- (void)hideLoading
{
    [_loadingIndicator stopAnimating];
}

- (void)setupSipView
{
    _passwordField = [[CFCASip  alloc] initWithFrame:_sipPositionView.frame];
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordField.secureTextEntry = YES;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.placeholder = @"输入6～15位密码";
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.backgroundColor = [UIColor clearColor];
    _passwordField.clearsOnBeginEditing = YES;
    _passwordField.font = [UIFont systemFontOfSize:14];
    [_passwordField setBorderStyle:UITextBorderStyleNone]; //
    
    _passwordField.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw=="; // base 64
    
    _passwordField.passwordMaxLength=15;
    _passwordField.passwordMinLength=6;
    _passwordField.outputValueType = 2;
    _passwordField.passwordRegularExpression = @"[a-zA-Z0-9]*";//^[0-9]{6}$ 
    _passwordField.sipdelegate = self;
    [self addSubview:_passwordField];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.3, 1.3);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.15
                                          animations:^{
                                              self.transform = CGAffineTransformMakeScale(0.5, 0.5);
                                              self.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [bgView removeFromSuperview];
                                              bgView = nil;
                                              [self removeFromSuperview];
                                              self._isShowing = NO;
                                          }];
                     }];
}
#pragma mark - authorizeRequest methods
-(NSString *)getRadom
{
    NSInteger radom = arc4random()%10000;
    return [NSString stringWithFormat:@"%d",radom];
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
    
    if ([_appLoginType isEqualToString:@"ASR"]) {
        
        NSDictionary *params = @{@"client_id":_appKey,
                                 @"client_secret":_appSecret,
                                 @"user_id":_userNameTextField.text,
                                 @"password":_password,
                                 @"enctyp":@"0",
                                 @"state":[self getRadom],
                                 @"response_type":@"code"};
        
        BOCOPPayAuthorizeASRDataRequest *request = [BOCOPPayAuthorizeASRDataRequest requestWithParams:params];
        
        request.postJSON = [NSString stringWithFormat:@"{\"enrandom\":\"%@\",\"randomid\":\"%@\"}",_randCode,_serverRandId];
        BOCOPDINFO(@"post JSON:%@",request.postJSON);
        [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
            BOCOPDINFO(@"parsed auth result:%@",result);
            if (_onLoginSuccess) {
                
                BOCOPPayAuthorizeInfo *authInfo = [[BOCOPPayAuthorizeInfo alloc] init];
                authInfo.userId = _userNameTextField.text;
                authInfo.clientId = _appKey;
                authInfo.accessToken = result[@"access_token"];
                authInfo.refreshToken = result[@"refresh_token"];
                authInfo.tokenType = result[@"token_type"];
                authInfo.welCome = result[@"welcome"];
                authInfo.realname = result[@"realname"];
                int expiresIn = [result[@"expires_in"] intValue];
                authInfo.expireTime = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
                authInfo.Cookie = request.Cookie;
                _onLoginSuccess(authInfo);
                [authInfo release];
            }
            _isLogging = NO;
            [self hideLoading];
            [self dismiss];
        }];
        
        [request onRequestFailWithError:^(NSError *error) {
            BOCOPDINFO(@"error:%@",error);
            
            if (_onLoginFail) {
                _onLoginFail(error);
            }
            _isLogging = NO;
            [self hideLoading];
        }];
        
        [self showLoading];
        [request connect];
    }else
    {
        NSDictionary *params = @{@"client_id":_appKey,
                                 @"client_secret":_appSecret,
                                 @"user_id":_userNameTextField.text,
                                 @"password":_password,
                                 @"enctyp":@"0",
                                 @"grant_type":@"implicit"};
        BOCOPPayAuthorizeDataRequest *request = [BOCOPPayAuthorizeDataRequest requestWithParams:params];
        
        request.postJSON = [NSString stringWithFormat:@"{\"enrandom\":\"%@\",\"randomid\":\"%@\"}",_randCode,_serverRandId];
        BOCOPDINFO(@"post JSON:%@",request.postJSON);
        [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
            BOCOPDINFO(@"parsed auth result:%@",result);
            if (_onLoginSuccess) {
                
                BOCOPPayAuthorizeInfo *authInfo = [[BOCOPPayAuthorizeInfo alloc] init];
                authInfo.userId = _userNameTextField.text;
                authInfo.clientId = _appKey;
                authInfo.accessToken = result[@"access_token"];
                authInfo.refreshToken = result[@"refresh_token"];
                authInfo.tokenType = result[@"token_type"];
                authInfo.ismsgfull = result[@"ismsgfull"];
                int expiresIn = [result[@"expires_in"] intValue];
                authInfo.expireTime = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
                
                _onLoginSuccess(authInfo);
                [authInfo release];
            }
            _isLogging = NO;
            [self hideLoading];
            [self dismiss];
        }];
        
        [request onRequestFailWithError:^(NSError *error) {
            BOCOPDINFO(@"error:%@",error);
            
            if (_onLoginFail) {
                _onLoginFail(error);
            }
            _isLogging = NO;
            [self hideLoading];
        }];
        
        [self showLoading];
        [request connect];
    }
    
    
    
}
#pragma mark - public methods
- (void)setAppKey:(NSString*)appKey appSecret:(NSString*)appSecret appLoginType:(NSString *)appLoginType
{
    [_appKey release];
    _appKey = nil;
    [_appSecret release];
    _appSecret = nil;
    [_appLoginType release];
    _appLoginType = nil;
    
    _appKey = [appKey retain];
    _appSecret = [appSecret retain];
    _appLoginType = [appLoginType retain];
}

- (void)show
{
    if (self._isShowing) {
        return;
    }
    self._isShowing = YES;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    self.center = CGPointMake(window.bounds.size.width/2, 150);
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    if (!bgView) {
        bgView = [[UIView alloc] initWithFrame:window.frame];
        bgView.backgroundColor = [UIColor clearColor];
        [window addSubview:bgView];
        [bgView release];
    }
    
    [window addSubview:self];
    
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.15
                                          animations:^{
                                              self.transform = CGAffineTransformMakeScale(0.9, 0.9);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.15
                                                               animations:^{
                                                                   self.transform = CGAffineTransformIdentity;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [_userNameTextField becomeFirstResponder];
                                                                   
                                                               }];
                                          }];
                     }];
}

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


- (void)onLoginCancel:(void (^)(void))onLoginCancel
{
    [_onLoginCancel release];
    _onLoginCancel = nil;
    _onLoginCancel = [onLoginCancel copy];
}

- (IBAction)onCancelBtnClicked:(id)sender {
    if (_onLoginCancel) {
        _onLoginCancel();
    }
    [[BOCOPPayRequestManager sharedManager] cleanAllRequest];
    [self dismiss];
}


- (IBAction)onLoginBtnClicked:(id)sender {
//    if (_isLogging) {
//        return;
//    }
//    _isLogging = YES;
//    if ([_userNameTextField.text length] == 0) {
//        
//        UIAlertView *alertView  = [[[UIAlertView alloc] initWithTitle:@""
//                                                              message:@"请输入用户名"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"确定"
//                                                    otherButtonTitles:nil] autorelease];
//        alertView.tag = BOCOPPayAuthorizeViewAlertTypeEmptyUserName;
//        [alertView show];
//        _isLogging = NO;
//        return;
//    }else if([_userNameTextField.text length]<6 || [_userNameTextField.text length]>20)
//    {
//        UIAlertView *alertView  = [[[UIAlertView alloc] initWithTitle:@"输入有误"
//                                                              message:@"用户名长度输入不合法"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"确定"
//                                                    otherButtonTitles:nil] autorelease];
//        alertView.tag = BOCOPPayAuthorizeViewAlertTypeEmptyUserName;
//        [alertView show];
//        _isLogging = NO;
//        return;
//    }

    BOCOPDINFO(@"version: %@",[_passwordField getVersion]);
    
    NSDictionary *headers = @{@"clentid":_appKey,@"userid ":_userNameTextField.text};
    [_passwordField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    BOCOPPayAuthorizeGetRandomNumDataRequest *request = [BOCOPPayAuthorizeGetRandomNumDataRequest requestWithHeaders:headers];
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        
        if ([result[@"random"] length]==0) {
            UIAlertView *alertView  = [[[UIAlertView alloc] initWithTitle:@""
                                                                  message:@"服务器异常，请稍后再试"
                                                                 delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil] autorelease];
            alertView.tag = BOCOPPayAuthorizeViewAlertTypeEmptyUserName;
            [alertView show];
            _isLogging = NO;
            return;
        }
        
        [_serverRandId release];
        _serverRandId = nil;
        _serverRandId = [result[@"randomid"] retain];
        
        [_serverRandNum release];
        _serverRandNum = nil;
        _serverRandNum = [result[@"random"] retain];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startProcessSip];
        });
        
        
        [self hideLoading];
    }];
    [request onRequestFailWithError:^(NSError *error) {
        BOCOPDINFO(@"Error when getting random num from server:%@",error);
        [self hideLoading];
        if (_onLoginFail) {
            _onLoginFail(error);
        }
        
        _isLogging = NO;
    }];
    [request connect];
    [self showLoading];

}
- (void)startProcessSip
{
    NSString *base64RandomCode = [self getBase64RandomCode:_serverRandNum];
    BOCOPDINFO(@"originalCode:%@,base64Code:%@",_serverRandNum,base64RandomCode);
    _passwordField.randomeKey_S = base64RandomCode; // base 64
    
    
    //_passwordField.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    // 输入验证码，获取加密口令和随机数
    [_passwordField getValue];
}
#pragma mark - AfterSipDelegator
- (void)actionAfterSip:(int)resultType
        passwordResult:(NSString *)passwordResult
         randomCResult:(NSString *)randomCResult
             errorCode:(NSString *)errorCode
          errorMessage:(NSString *)errorMessage;
{
    if (resultType == 0) {
        //success
        if (errorCode) {
            //basic validation
            BOCOPDINFO(@"errorCode[%@],errorMessage[%@]",errorCode,errorMessage);
            //show error message
            UIAlertView *alertView  = [[[UIAlertView alloc] initWithTitle:@"输入有误"
                                                                  message:errorMessage
                                                                 delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil] autorelease];
            alertView.tag = BOCOPPayAuthorizeViewAlertTypeMalformPassword;
            [alertView show];
            _isLogging = NO;
        }else{
            BOCOPDINFO(@"passwordResult:%@\n randomCResult:%@",passwordResult,randomCResult);
            [_password release];
            _password = nil;
            _password = [passwordResult retain];
            
            [_randCode release];
            _randCode = nil;
            _randCode = [randomCResult retain];
            
            //do login
            [self doLogin];
        }
    }else if (resultType == 1){
        //cancel
        _isLogging = NO;
    }
}


#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == BOCOPPayAuthorizeViewAlertTypeEmptyUserName) {
        [_userNameTextField becomeFirstResponder];
    }else if(alertView.tag == BOCOPPayAuthorizeViewAlertTypeMalformPassword){
        
        [_passwordField becomeFirstResponder];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    BOCOPDINFO(@"验证输入");
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:CANUSECHARACTER ] invertedSet]; //invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];  //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字字母或者下划线"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        [alert release];
        return NO;
    }
    // Add any predicate testing here
    return basicTest;
}

@end
