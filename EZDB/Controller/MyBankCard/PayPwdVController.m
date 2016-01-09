//
//  PayPwdVController.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-4.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PayPwdVController.h"
#import "GenVCPEntityRequest.h"
#import "VerifyVCPPwdRequest.h"
#import "AddCardViewController.h"
#import "LoginViewController.h"
#import "GetServerRandomRequest.h"
#import "VerifyMsgCodeRequest.h"
#include "Base64Transcoder.h"

@interface PayPwdVController ()
{
    NSDictionary *entity;
}
@end

@implementation PayPwdVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        entity = [NSDictionary dictionary];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBar];
    [self setTextField];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - 
- (void)setNavBar
{
    [self setNavBarWithtitle:kBindCardTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
    [self.submitBtn setBackgroundColor:kBtnBackGroudColor];
}
- (void)setTextField
{
    self.payPwdTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.payPwdTf.secureTextEntry = YES;
    self.payPwdTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.payPwdTf.returnKeyType = UIReturnKeyDone;
    self.payPwdTf.backgroundColor = [UIColor clearColor];
    self.payPwdTf.clearsOnBeginEditing = YES;
    self.payPwdTf.font = [UIFont systemFontOfSize:14];
    self.payPwdTf.borderStyle = UITextBorderStyleNone;
    self.payPwdTf.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    self.payPwdTf.passwordMaxLength=20;
    self.payPwdTf.passwordMinLength=6;
    self.payPwdTf.outputValueType=2;
    self.payPwdTf.passwordRegularExpression = @"[a-zA-Z0-9!@#$%^&*_]*";
    self.payPwdTf.delegate = self;
    self.payPwdTf.sipdelegate = self;
    
}

#pragma mark - UITextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.payPwdTf) {
        if (range.location>=20) {
            return NO;
        }else
            return YES;
    }
    return YES;
}

#pragma mark - 获取服务端随机数
- (void)getServerRadom
{
    BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
    GetServerRandomRequest *request = [GetServerRandomRequest requestWithHeaders:nil];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
    NSDictionary *params =@{@"AppName":@"ezdb"};
    request.headers = headers;
    request.postJSON = [params JSONString];
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        self.serverRandNum = result[@"serverRandom"];
        NSLog(@"__serverRandNum %@",self.serverRandNum);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *base64RandomCode = [self getBase64RandomCode:self.serverRandNum];
            self.payPwdTf.sipdelegate = self;
            self.payPwdTf.randomeKey_S = base64RandomCode;
            [self.payPwdTf getValue];

        });
    }];
    [request onRequestFailWithError:^(NSError *error) {
        __Login_Invailid_;
    }];
    
    [request connect];
    
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

#pragma mark - delegate method
#ifdef FORPRODUCT
- (void)actionAfterSip:(int)resultType
        passwordResult:(NSString *)passwordResult
         randomCResult:(NSString *)randomCResult
             errorCode:(NSString *)errorCode
          errorMessage:(NSString *)errorMessage
                object:(CFCASip *)sip
#else
- (void)actionAfterSip:(int)resultType
        passwordResult:(NSString *)passwordResult
         randomCResult:(NSString *)randomCResult
             errorCode:(NSString *)errorCode
          errorMessage:(NSString *)errorMessage
{
    if (resultType==0) {
        if (errorCode) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSDictionary *errorInfo = @{@"error_code":errorMessage,@"error_description":errorMessage};
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"  message:errorInfo[@"error_description"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            self.pdResult = passwordResult;
            self.randomResult = randomCResult;
            NSDictionary *data = @{@"OldPass":self.pdResult,
                                   @"OldPass_RC":self.randomResult,
                                   @"rs":self.serverRandNum};
            
            NSDictionary *passwordDTO = @{@"data":data};
        
            NSDictionary *params = @{@"custNo":[UserInfoSample shareInstance].userItems[@"uid"],
                                    @"passwordDTO":passwordDTO,};
            BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
            VerifyVCPPwdRequest *request = [VerifyVCPPwdRequest requestWithHeaders:nil];
            
            NSMutableDictionary *headParameters = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
            
            request.headers = headParameters;
            request.postJSON = [params JSONString];
            [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
                NSLog(@"serviceResponse %@",result);
                if ([result[@"responseCode"]isEqualToString:_responseCode_PayPwd_Done]) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    //支付密码验证成功
                    GOTO_NEXTVIEWCONTROLLER(AddCardViewController,
                                            @"AddCardViewController35",
                                            @"AddCardViewController");
                }else{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
//                    [self showNBAlertWithAletTag:110 Title:@"温馨提醒" content:result[@"responseMsg"] btnArray:arr];
                    //for test addCard
                    GOTO_NEXTVIEWCONTROLLER(AddCardViewController,
                                            @"AddCardViewController35",
                                            @"AddCardViewController");
                }
            }];
            
            [request onRequestFailWithError:^(NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                __Login_Invailid_;
            }];
            [request connect];
        }
    }
}
#endif

#pragma mark - submit Btn Click
- (IBAction)submitClick:(BorderSetBtn *)sender
{
    [self.payPwdTf resignFirstResponder];
    if (self.payPwdTf.text.length==0) {
        [MSUtil showHudMessage:@"支付密码不能为空" hideAfterDelay:1.5 uiview:self.view];
    }else if(self.payPwdTf.text.length<6||self.payPwdTf.text.length>20){
        [MSUtil showHudMessage:@"支付密码长度不符合" hideAfterDelay:1.5 uiview:self.view];
    }else{
        [self getServerRadom];
    }
}

#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag]==111) {
        [alertView close];
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }else if([alertView tag]==113||
             [alertView tag]==114||
             [alertView tag]==110){
        [alertView close];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
