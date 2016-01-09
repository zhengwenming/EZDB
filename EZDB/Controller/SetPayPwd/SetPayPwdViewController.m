//
//  SetPayPwdViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-27.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "SetPayPwdViewController.h"
#import "ReviseSucVController.h"
#import "SetPayPwdDataRequest.h"
#import "LoginViewController.h"
#import "BorderSetBtn.h"
#include "Base64Transcoder.h"
#import "GetServerRandomRequest.h"

@interface SetPayPwdViewController ()<AfterSipDelegator,UITextFieldDelegate>

@end

@implementation SetPayPwdViewController
int __counter = 1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSubviews];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index==2){
       
    }
}
#pragma mark -setSubviews
- (void)setSubviews
{
    if (kDeviceVersion>=7.0) {
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:kSetPayPwdTitle lBtnImg:kNavBackImgName rBtnImg:nil];
    }else{
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:kSetPayPwdTitle lBtnImg:kNavBackImgName rBtnImg:nil];
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y += 35;
            v.frame = rect;
        }
    }
    self.navView.delegate = (id<PopViewContrlDelegate>)self;
    [self.view addSubview:self.navView];
    self.sView.backgroundColor = [self getBackGroundColor];
    
    self.setPwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.setPwdTextField.secureTextEntry = YES;
    self.setPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.setPwdTextField.returnKeyType = UIReturnKeyDone;
    self.setPwdTextField.backgroundColor = [UIColor clearColor];
    self.setPwdTextField.clearsOnBeginEditing = YES;
    self.setPwdTextField.font = [UIFont systemFontOfSize:14];
    self.setPwdTextField.borderStyle = UITextBorderStyleNone;
    self.setPwdTextField.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    self.setPwdTextField.passwordMaxLength=20;
    self.setPwdTextField.passwordMinLength=6;
    self.setPwdTextField.outputValueType=2;
    self.setPwdTextField.passwordRegularExpression = @"[a-zA-Z0-9!@#$%^&*_]*";
    self.setPwdTextField.delegate = self;
    self.setPwdTextField.sipdelegate = self;
    
    self.confirmTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.confirmTextField.secureTextEntry = YES;
    self.confirmTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmTextField.returnKeyType = UIReturnKeyDone;
    self.confirmTextField.backgroundColor = [UIColor clearColor];
    self.confirmTextField.clearsOnBeginEditing = YES;
    self.confirmTextField.font = [UIFont systemFontOfSize:14];
    self.confirmTextField.borderStyle = UITextBorderStyleNone;
    self.confirmTextField.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    self.confirmTextField.passwordMaxLength=20;
    self.confirmTextField.passwordMinLength=6;
    self.confirmTextField.outputValueType=2;
    self.confirmTextField.passwordRegularExpression = @"[a-zA-Z0-9!@#$%^&*_]*";//
    self.confirmTextField.delegate = self;
    self.confirmTextField.sipdelegate = self;
    
    [self.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark -
- (void)submitBtnClick:(BorderSetBtn *)sender
{
    if ([self.setPwdTextField.text isEqualToString:@""]) {
        [MSUtil showHudMessage:@"设置密码不能为空" hideAfterDelay:1.5 uiview:self.view];
        
    }else if ([self.confirmTextField.text isEqualToString:@""]) {
        [MSUtil showHudMessage:@"确认密码不能为空" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(self.setPwdTextField.text.length<6||self.setPwdTextField.text.length>20){
        [MSUtil showHudMessage:@"设置密码长度不符合" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(self.confirmTextField.text.length<6||self.confirmTextField.text.length>20){
        [MSUtil showHudMessage:@"确认密码长度不符合" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(self.setPwdTextField.text.length!=self.confirmTextField.text.length){
        [MSUtil showHudMessage:@"两次密码长度不匹配" hideAfterDelay:1.5 uiview:self.view];
        
    }else{
        [self.confirmTextField resignFirstResponder];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self getServerRadom];
    }
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
//            NSString *base64RandomCode = [self getBase64RandomCode:self.serverRandNum];
                self.setPwdTextField.sipdelegate = self;
                self.setPwdTextField.randomeKey_S = self.serverRandNum;
                [self.setPwdTextField getValue];
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
            if(__counter==1) {
                self.pdResult = passwordResult;
                NSLog(@"*******   first is %@",self.pdResult);
                self.randomResult = randomCResult;
                __counter++;
                NSLog(@"--------%d",__counter);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(__counter==2){
                        self.confirmTextField.sipdelegate = self;
                        self.confirmTextField.randomeKey_S = self.serverRandNum;
                        [self.confirmTextField getValue];
                        NSLog(@"__counter %d___ ",__counter);
                    }
                });
            }else if (__counter==2){
                self.pdResult2 = passwordResult;
                self.randomResult2 = randomCResult;
                NSLog(@"*******   second is %@",self.pdResult2);
                NSDictionary *data = @{@"OldPass":self.pdResult,
                                       @"OldPass_RC":self.randomResult,
                                       @"NewPass":self.pdResult2,
                                       @"NewPass_RC":self.randomResult2,
                                       @"rs":self.serverRandNum};
                
                NSDictionary *passwordDTO = @{@"data":data};
                
                NSDictionary *params =@{@"custNo":[UserInfoSample shareInstance].userItems[@"uid"],
                                        @"loginName":[BOCOPLogin sharedInstance].userName,
                                        @"passwordDTO":passwordDTO,};
                BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
                SetPayPwdDataRequest *setPayRequest = [SetPayPwdDataRequest requestWithHeaders:nil];
                
                NSMutableDictionary *headParameters = [NSMutableDictionary dictionaryWithDictionary:[setPayRequest getBusinessRequestHeaderDictionary:authorizeInfo]];
                
                setPayRequest.headers = headParameters;
                setPayRequest.postJSON = [params JSONString];
                [setPayRequest onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
                    if ([result[@"responseCode"]isEqualToString:_responseCode_PayPwd_Done]) {
                        __counter = 1;
                        [UserInfoSample shareInstance].isSetPayPwd = YES;
                        NSLog(@"result___________^^^^^  %@",result);
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        ReviseSucVController *sucVc = [[ReviseSucVController alloc]initWithNibName:@"ReviseSucVController" bundle:nil];
                        sucVc.titleStr = kSetPayPwdTitle;
                        sucVc.labelStr = @"恭喜您，设置成功";
                        [self.navigationController pushViewController:sucVc animated:YES];

                    }else if ([result[@"msgcde"]isEqualToString:@"ASR-000003"]||
                                [result[@"msgcde"]isEqualToString:@"ASR-000005"]||
                                [result[@"msgcde"]isEqualToString:@"invalid_token"]) {
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        [BOCOPLogin sharedInstance].isLogin = NO;

                        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
                        [self showNBAlertWithAletTag:111 Title:@"温馨提醒" content:result[@"rtnmsg"] btnArray:arr];
                    }else{
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
                        [self showNBAlertWithAletTag:110 Title:@"温馨提醒" content:result[@"responseMsg"] btnArray:arr];
                    }
                }];
                
                [setPayRequest onRequestFailWithError:^(NSError *error) {
                    [UserInfoSample shareInstance].isSetPayPwd = NO;
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    __Login_Invailid_;
                }];
                [setPayRequest connect];
            }
        }
    }
}
#endif

#pragma mark -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // return NO to not change text
    if (textField==self.setPwdTextField||textField==self.confirmTextField) {
        if (range.location>=20) {
            return NO;
        }else
            return YES;
    }
    return YES;
}

#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag]==111) {
        [alertView close];
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }else if([alertView tag]==110){
        [alertView close];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    __counter = 1;
}
@end
