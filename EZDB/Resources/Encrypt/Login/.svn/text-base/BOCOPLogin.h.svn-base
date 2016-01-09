

#import <Foundation/Foundation.h>
#import "CFCASip.h"
#import "BOCOPPayAuthorizeGetRandomNumDataRequest.h"
#import "BOCOPPayAuthorizeASRDataRequest.h"
#import "BOCOPPayObjectSingleton.h"
#import "BOCOPPayAuthorizeInfo.h"

@protocol LoginBackDelegate <NSObject>

-(void)loginCallBack;

@end


typedef enum {
    CalledFromHome = 0,
    CalledFromOperate = 1,
} CalledType;

@interface BOCOPLogin : NSObject <AfterSipDelegator>
{
    void (^_onLoginSuccess)(BOCOPPayAuthorizeInfo *);
    void (^_onLoginFail)(NSError *);
    void (^_onLogoutSuccess)(void);
    void (^_onLoginCancel)(void);
}
@property (nonatomic,copy) NSString *userName;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic,retain) NSString *serverRandId;
@property (nonatomic,retain) NSString *serverRandNum;

@property (nonatomic,retain) NSString *pdResult;
@property (nonatomic,retain) NSString *randomResult;
@property (nonatomic,retain) NSString *cookie;

@property (nonatomic,retain) BOCOPPayAuthorizeInfo *authInfo;

@property (nonatomic,retain) UITextField *userNameField;

@property (nonatomic,retain) CFCASip *encryCtrl;

@property (nonatomic,assign) BOOL isLogin;

@property (nonatomic,assign) CalledType calledType;

@property (nonatomic,assign) id delegate;

+ (BOCOPLogin *)sharedInstance;

- (id)initWithAppKey:(NSString *)appKey
           appSecret:(NSString *)appSecrect
        appLoginType:(NSString *)appLoginType
                 URL:(NSString *)serverUrl
              asrURL:(NSString *)asrURL;

- (void)logOut;

- (BOOL)isBocopLogin;

- (BOOL)isAuthorizeExpired;

- (void)logIn;

-(void)GetRandomNumData;

- (void)onLoginSuccess:(void (^)(BOCOPPayAuthorizeInfo *authorizeInfo))onLoginSuccess;

- (void)onLoginFail:(void (^)(NSError *error))onLoginFail;

- (void)onLogoutSuccess:(void (^)(void))onLogoutSuccess;

- (void)onLoginCancel:(void (^)(void))onLoginCancel;



@end
