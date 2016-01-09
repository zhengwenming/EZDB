//
//  BOCPayAuthorizeView.h
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2013 BOC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AfterSipDelegator.h"
#import "BOCOPPayAuthorizeInfo.h"

@interface BOCOPPayAuthorizeView : UIView <AfterSipDelegator,UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic) BOOL _isShowing;
+ (BOCOPPayAuthorizeView*)viewFromNib;
- (void)setAppKey:(NSString*)appKey appSecret:(NSString*)appSecret appLoginType:(NSString *)appLoginType;

- (void)show;

- (void)onLoginSuccess:(void (^)(BOCOPPayAuthorizeInfo *authorizeInfo))onLoginSuccess;

- (void)onLoginFail:(void (^)(NSError *error))onLoginFail;

- (void)onLoginCancel:(void (^)(void))onLoginCancel;
@end
