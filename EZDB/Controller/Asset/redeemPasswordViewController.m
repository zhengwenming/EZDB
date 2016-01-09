//
//  redeemPasswordViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "redeemPasswordViewController.h"
#import "redeemSuccessController.h"
#import "ChangePwdViewController.h"
#import "RedeemRequest.h"
#import "RedeemResultRequestr.h"
#import "GetServerRandomRequest.h"
#import "RedeemResultModel.h"
#include "Base64Transcoder.h"

@interface redeemPasswordViewController ()<AfterSipDelegator>

@end

@implementation redeemPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarWithtitle:@"赎回" superView:self.view backImg:kNavBackImgName homeImg:nil];
    [self.view setBackgroundColor:kViewBackGroudColor];
//    test
    self.passwordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.returnKeyType = UIReturnKeyDone;
    self.passwordTF.backgroundColor = [UIColor clearColor];
    self.passwordTF.clearsOnBeginEditing = YES;
    self.passwordTF.font = [UIFont systemFontOfSize:14];
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    self.passwordTF.passwordMaxLength=20;
    self.passwordTF.passwordMinLength=6;
    self.passwordTF.outputValueType=2;
    self.passwordTF.passwordRegularExpression = @"[a-zA-Z0-9!@#$%^&#$%^&amp;#$%^&#$%^&amp;amp;*_]*";
    self.passwordTF.delegate = self;
    self.passwordTF.sipdelegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - 确定支付 事件
- (IBAction)submitAction:(id)sender {
    //    确定  支付点击事件
    //    发送赎回请求 若返回成功则跳转赎回成功界面
    
    [self.passwordTF resignFirstResponder];
    if (self.passwordTF.text.length==0) {
        [MSUtil showHudMessage:@"支付密码不能为空" hideAfterDelay:1.5 uiview:self.view];
    }else if(self.passwordTF.text.length<6||self.passwordTF.text.length>20){
        [MSUtil showHudMessage:@"支付密码长度不符合" hideAfterDelay:1.5 uiview:self.view];
    }else{
//        [self getServerRadom];
    }
    //
    //    GOTO_NEXTVIEWCONTROLLER(redeemSuccessController, @"redeemSuccessController", @"redeemSuccessController");
    
}
#pragma mark - 忘记密码
- (IBAction)forgetPasswordAction:(id)sender {
    //    忘记密码
    GOTO_NEXTVIEWCONTROLLER(ChangePwdViewController, @"ChangePwdViewController", @"ChangePwdViewController");
}



- (NSString *)getBase64RandomCode:(NSString*)randomCode
{
    int length = [randomCode lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    char inputData[length];
    
    [[randomCode dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData length:length];
    size_t inputDataSize = (size_t)[randomCode length];
    size_t outputDataSize = EstimateBas64EncodedDataSize(inputDataSize);//calculate the decoded data size
    char outputData[outputDataSize];//prepare a Byte[] for the decoded data
    Base64EncodeData(inputData, inputDataSize, outputData, &outputDataSize);//decode the data
    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];//create a NSData object from the decoded data
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    
	return base64EncodedResult;
}//


#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];
    //    if ([alertView tag]==111) {
    //        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
    //                                @"LoginViewController",
    //                                @"LoginViewController4");
    //    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
