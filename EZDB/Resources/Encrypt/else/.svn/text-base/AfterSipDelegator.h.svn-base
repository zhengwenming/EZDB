//
//  AfterSipDelegator.h
//  CFCASip
//
//  Created by 超级大光棍 on 11-11-11.
//  Copyright 2011 CFCA. All rights reserved.
//
@class CFCASip;
@protocol AfterSipDelegator
@required

/*!
 @function
 @abstract   SIP动作完成后处理
 @param      [in]		resultType			结果类型（成功0、用户取消1）
 [in]		passwordResult		输入信息的加密结果
 [in]		randomCResult		客户端随机数b
 [in]		errorCode			错误信息（格式为 “错误码”）
 [in]		errorMessage		错误信息（格式为 “错误信息”）
 @result
 */
- (void)actionAfterSip:(int)resultType
        passwordResult:(NSString *)passwordResult
         randomCResult:(NSString *)randomCResult
             errorCode:(NSString *)errorCode
          errorMessage:(NSString *)errorMessage;

@optional
/*!
 @function
 @abstract   当用户点击安全键盘的“完成键”的回掉函数
 @param      [in]		sip         触发此动作的控件，以方便有多个控件时的处理。
 @result
 */
-(void)actionAfterDone:(CFCASip *)sip;

@end

