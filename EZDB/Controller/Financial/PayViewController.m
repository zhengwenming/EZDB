//
//  PayViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/14.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PayViewController.h"
#import "BindGetCodeRequest.h"
#import "VerifyMsgCodeRequest.h"
#import "LoginViewController.h"
#import "BindGetCodeRequest.h"
#import "VerifyVCPPwdRequest.h"
#import "GetServerRandomRequest.h"
#import "SubscribeDataRequest.h"
#import "SubscribeResultRequest.h"
#import "SubscribModel.h"
#include "Base64Transcoder.h"

@interface PayViewController ()
{
    NSTimer                 *counter;
    NSString                *phoneNo;
    NSString                *odrNo;
}

@end


static int __time = 59;

@implementation PayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    __time = 59;
    counter = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSubViews];
    
}

- (void)setUpSubViews
{
    //nav
    [self setNavBarWithtitle:kPurchaseTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
    //textField
    self.SMSCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.SMSCodeTextField.delegate = self;
    
    self.passWordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passWordTextField.secureTextEntry = YES;
    self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTextField.returnKeyType = UIReturnKeyDone;
    self.passWordTextField.backgroundColor = [UIColor clearColor];
    self.passWordTextField.clearsOnBeginEditing = YES;
    self.passWordTextField.font = [UIFont systemFontOfSize:14];
    self.passWordTextField.borderStyle = UITextBorderStyleNone;
    self.passWordTextField.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    self.passWordTextField.passwordMaxLength=20;
    self.passWordTextField.passwordMinLength=6;
    self.passWordTextField.outputValueType=2;
    self.passWordTextField.passwordRegularExpression = @"[a-zA-Z0-9!@#$%^&*_]*";
    self.passWordTextField.delegate = self;
    self.passWordTextField.sipdelegate = self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forgetPasswordButtonAction:(UIButton *)sender
{
    
}

#pragma mark - 定时器changeTime
- (void)changeTime
{
    __time --;
    [self.getSMSCodeButton setTitle:[NSString stringWithFormat:@"重新获取(%d)",__time] forState:UIControlStateNormal];
    if (__time==-1) {
        [counter invalidate];
        [self.getSMSCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.getSMSCodeButton setUserInteractionEnabled:YES];
        __time = 59;
    }
}
#pragma  mark - 点击确定
- (IBAction)submitButtonAction:(UIButton *)sender
{
    [self.passWordTextField resignFirstResponder];
    if (self.passWordTextField.text.length==0) {
        [MSUtil showHudMessage:@"支付密码不能为空" hideAfterDelay:1.5 uiview:self.view];
    }else if(self.passWordTextField.text.length<6||self.passWordTextField.text.length>20){
        [MSUtil showHudMessage:@"支付密码长度不符" hideAfterDelay:1.5 uiview:self.view];
    }else if(self.SMSCodeTextField.text.length<6||self.SMSCodeTextField.text.length>6){
        [MSUtil showHudMessage:@"验证码长度不符" hideAfterDelay:1.5 uiview:self.view];
    }else{
//        [self getServerRandom];
    }
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
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.passWordTextField) {
        if (range.location>=20) {
            return NO;
        }else
            return YES;
    }else if(textField==self.SMSCodeTextField){
        if (range.location>=6) {
            return NO;
        }else
            return YES;
    }
    return YES;
}
#pragma mark - 其他
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];
    if ([alertView tag]==19) {
    }else if([alertView tag]==16||
             [alertView tag]==111){
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }
}
@end
