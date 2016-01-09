//
//  MSServiceContent.m
//  EggplantAlbums
//
//  Created by yeby on 13-8-6.
//  Copyright (c) 2013年 YunInfo. All rights reserved.
//

#import "Reachability.h"


@interface MSUtil : NSObject

+ (NSDictionary*)dictionaryFromBundleWithName:(NSString*)fileName withType:(NSString*)typeName;
//字符串MD5转换
+ (NSString *)md5HexDigest:(NSString*)input;
//时间格式
+ (NSDate *)getNowTime;
+ (NSString *)getyyyymmdd;
+ (NSString *)gethhmmss;
+ (NSDictionary *)getHeaders;
+ (void)showTipsWithHUD:(NSString *)labelText showTime:(CGFloat)time;
+ (void)showTipsWithView:(UIView *)uiview labelText:(NSString *)labelText showTime:(CGFloat)time;
+ (void) showHudMessage:(NSString*) msg hideAfterDelay:(NSInteger) sec uiview:(UIView *)uiview;

//+ (NetworkStatus)getCurrentNetworkStatus;
+ (NetworkStatus)getCurrentNetworkStatusForLocal;
+ (void)showNotReachabileTips;

+ (NSDate *)dateFromString:(NSString *)dateString usingFormat:(NSString*)format;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString*)format;

//判断银行标识(logo)
+ (void)judgeBankIDWith:(NSString *)str img:(UIImageView *)img;
+ (void)judgeBankLogoWith:(NSString *)str img:(UIImageView *)img;

//获取后台服务器主机名
//+(NSString*)readFromUmengOlineHostname;
//获取后台api字典
+ (NSDictionary * )getURLs;

//loadingView方法集
+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle;
+(void)removeLoadingViewInView:(UIView*)viewToLoadData;
+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle usingColor:(UIColor*)color;
+(void)removeLoadingViewAndLabelInView:(UIView*)viewToLoadData;
+(void)addLoadingViewAndLabelInView:(UIView*)viewToLoadData usingOrignalYPosition:(CGFloat)yPosition;
+(void)addLoadingViewAndLabelInView:(UIView*)viewToLoadData;
+(void)showProgessInView:(UIView *)view withExtBlock:(void (^)())exBlock withComBlock:(void (^)())comBlock;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation; //图片旋转

//将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png" 
+ (void)saveImagetoLocal:(UIImage*)image imageName:(NSString *)imageNameString;
+ (NSString *)getDeviceOSType;

+(NSString *)getFlag;       //
+(NSString *)fileMd5sum:(NSString * )filename; //md5转换

+(id)loadFromXIB:(NSString *)XIBName;

//判断字符串长度
+ (int)convertToInt:(NSString*)strtemp;
//end

+(NSMutableArray *)decorateString:(NSString *)string;
//正则表达式部分
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;
//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode;
//month
+ (BOOL) validateMonth: (NSString *)month;
//year
+ (BOOL) validateYear: (NSString *)year;
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode;

@end
