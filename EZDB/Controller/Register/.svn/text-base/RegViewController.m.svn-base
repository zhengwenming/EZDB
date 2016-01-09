//
//  RegViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//
#import "RegViewController.h"
#import "RegSuccessViewController.h"
#import "LoginViewController.h"
#import "BOCProtocalViewController.h"
#include <QuartzCore/QuartzCore.h>
#import "BorderSetBtn.h"
#include "Base64Transcoder.h"

typedef enum : NSUInteger {
    kQueryUserIdRequest = 33,
    kRegisterRequest,
    kCheckPwdRequest,
} kRequestTpye;

@interface RegViewController ()
{
    CGRect      origRect;
    NSString    *navTitle;
}

@end


int count = 1;
@implementation RegViewController

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

    [self initUI];
    
}
- (void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:animated];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - PopViewContrlDelegate

- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==2){
    }
}

- (void)initUI
{
    
    self.userNameTF.delegate =self;
    self.userNameTF.returnKeyType = UIReturnKeyDone;
    self.pwdTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pwdTF.secureTextEntry = YES;
    self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdTF.placeholder = @"  请设置您的登录密码";
    self.pwdTF.returnKeyType = UIReturnKeyDone;
    self.pwdTF.backgroundColor = [UIColor whiteColor];
    self.pwdTF.clearsOnBeginEditing = YES;
    self.pwdTF.font = [UIFont systemFontOfSize:14];
    self.pwdTF.borderStyle = UITextBorderStyleNone;
    self.pwdTF.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";//base 64
    self.pwdTF.passwordMaxLength=15;
    self.pwdTF.passwordMinLength=6;
    self.pwdTF.outputValueType=2;
    self.pwdTF.passwordRegularExpression = @"[a-zA-Z0-9]*";//^[0-9]{6}$
    self.pwdTF.sipdelegate = self;
    
    self.pwdAgainTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pwdAgainTF.secureTextEntry = YES;
    self.pwdAgainTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdAgainTF.placeholder = @"  请确认您的登录密码";
    self.pwdAgainTF.returnKeyType = UIReturnKeyDone;
    self.pwdAgainTF.backgroundColor = [UIColor whiteColor];
    self.pwdAgainTF.clearsOnBeginEditing = YES;
    self.pwdAgainTF.font = [UIFont systemFontOfSize:14];
    self.pwdAgainTF.borderStyle = UITextBorderStyleNone;
    self.pwdAgainTF.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";//base 64
    self.pwdAgainTF.passwordMaxLength=15;
    self.pwdAgainTF.passwordMinLength=6;
    self.pwdAgainTF.outputValueType=2;
    self.pwdAgainTF.passwordRegularExpression = @"[a-zA-Z0-9]*";//^[0-9]{6}$
    self.pwdAgainTF.sipdelegate = self;

    if (kDeviceVersion>=7.0) {
    }else{
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y -= 20;
            v.frame = rect;
        }
    }
    [self setNavBarWithtitle:kRegisterTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
    
    //
    [self.registerButton setBackgroundColor:kBtnBackGroudColor];
    [self.registerButton setEnabled:NO];
    [self.registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.directLoginBtn setBackgroundColor:kRegBackGroudColor];
    [self.registerButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.directLoginBtn addTarget:self action:@selector(directLoginAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.agreeButton addTarget:self action:@selector(agreeProtocol:) forControlEvents:UIControlEventTouchUpInside];
    [self.protocolButton addTarget:self action:@selector(showProtocol:) forControlEvents:UIControlEventTouchUpInside];
    
    origRect = self.popIV.frame;
    self.popIV.frame = CGRectZero;
    self.popLabel.frame= CGRectZero;
}

- (void)agreeProtocol:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.registerButton.enabled = !self.registerButton.enabled;
    if (sender.selected) {
        [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}
- (void)showProtocol:(UIButton *)sender
{
    BOCProtocalViewController *protocolVC = [[BOCProtocalViewController alloc]init];
    protocolVC.navTitle = kRegisterTitle;
    [self.navigationController pushViewController:protocolVC animated:YES];
}
#pragma mark - 点击注册按钮
//注册按钮点击事件
-(void)registerAction:(UIButton *)sender
{
    if ([self.userNameTF.text isEqualToString:@""]) {

        [MSUtil showHudMessage:@"用户名不能为空" hideAfterDelay:1.5 uiview:self.view];
        
    }else if([self.pwdTF.text isEqualToString:@""]) {

        [MSUtil showHudMessage:@"登录密码不能为空" hideAfterDelay:1.5 uiview:self.view];
        
    }else if([self.pwdAgainTF.text isEqualToString:@""]) {

        [MSUtil showHudMessage:@"确认密码不能为空" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(self.pwdTF.text.length<6||self.pwdTF.text.length>20){
        
        [MSUtil showHudMessage:@"登录密码长度不符合" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(self.pwdAgainTF.text.length<6||self.pwdAgainTF.text.length>20){

        [MSUtil showHudMessage:@"确认密码长度不符合" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(self.pwdTF.text.length!=self.pwdAgainTF.text.length){

        [MSUtil showHudMessage:@"两次输入的密码长度不匹配" hideAfterDelay:1.5 uiview:self.view];

    }else if([MSUtil validateMobile:self.userNameTF.text]){

        [MSUtil showHudMessage:@"用户名不能为以1开头的11位数" hideAfterDelay:1.5 uiview:self.view];
        
    }else if(![MSUtil validateUserName:self.userNameTF.text]) {
            self.popIV.frame = origRect;
            self.popLabel.frame = origRect;
            [self.view bringSubviewToFront:self.popIV];
            [self.view bringSubviewToFront:self.popLabel];
            [self performSelector:@selector(dismissPopViews) withObject:nil afterDelay:1.5];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self getRandom];
    }
}

- (void)getRandom
{
    NSDictionary *headers = @{
                              @"clentid":kAppBopKey,
                              @"userid":self.userNameTF.text,
                              @"chnflg":@"1",
                              @"trandt":[MSUtil getyyyymmdd],
                              @"trantm":[MSUtil gethhmmss],
                              @"cookie":@""};
    NSLog(@"headers are %@",headers);
    [self.userNameTF resignFirstResponder];
    [self.pwdTF resignFirstResponder];

    BOCOPPayAuthorizeGetRandomNumDataRequest *request = [BOCOPPayAuthorizeGetRandomNumDataRequest requestWithHeaders:headers];

    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        if (count==1) {
            self.serverRandId2 = result[@"randomid"];
            self.serverRandNum2 = result[@"random"];
        }else if(count==2){
            self.serverRandId = result[@"randomid"];
            self.serverRandNum = result[@"random"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *base64RandomCode = [self getBase64RandomCode:self.serverRandNum2];
            if (count==1) {
                self.pwdTF.sipdelegate = self;
                self.pwdTF.randomeKey_S = base64RandomCode;
                [self.pwdTF getValue];
            }else if(count==2){
                self.pwdAgainTF.sipdelegate = self;
                self.pwdAgainTF.randomeKey_S = base64RandomCode;
                [self.pwdAgainTF getValue];
            }
        });
    }];
    [request onRequestFailWithError:^(NSError *error) {
        NSLog(@"error info == %@",[[error userInfo] objectForKey:@"error_description"]);
        NSString *errorName =[[error userInfo] objectForKey:@"error_description"];
        if ([[[error userInfo] objectForKey:@"error_description"] length]==0 && [[[error userInfo] objectForKey:@"error_code"] length]==0) {
            NSString *message = [error localizedDescription];
            if ([message isEqualToString:@"Could not connect to the server."]) {
                message = @"无法连接服务器！";
                
            }else if([message isEqualToString:@"The request timed out."]){
                message = @"连接服务器超时!";
                
            }else if([message isEqualToString:@"The operation couldn’t be completed."]){
                message = errorName;
            }
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];

            UIAlertView *alertVw = [[UIAlertView alloc] initWithTitle:@"温馨提示" message: message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertVw show];
            
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[[error userInfo] objectForKey:@"error_description"]];
//            NSString *msgcode = [error userInfo][@"error_code"];
            NSLog(@"code is %@",[error userInfo][@"error_code"]);
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            UIAlertView *alertVw = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertVw show];
        }
    }];
    [request connect];//1
}

#pragma mark - AfterSipDelegator
- (void)actionAfterSip:(int)resultType
        passwordResult:(NSString *)passwordResult
         randomCResult:(NSString *)randomCResult
             errorCode:(NSString *)errorCode
          errorMessage:(NSString *)errorMessage;//3
{
    if (resultType == 0) {
        if (errorCode) {
            NSDictionary *errorInfo = @{@"error_code":errorMessage,@"error_description":errorMessage};
            NSLog(@"____error code is %@",errorMessage);
            [[DBModalView shareModal]collapseModalView];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"  message:errorInfo[@"error_description"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            if (count==1) {
                self.pdResult2 = passwordResult;
                self.randomResult2 = randomCResult;
                NSLog(@"*******   first is %@",self.pdResult2);
                count++;
                NSLog(@"--------%d",count);
                [self sendRequest];
            }else if (count==2){
                self.pdResult = passwordResult;
                self.randomResult = randomCResult;
                NSLog(@"*******   second is %@",self.pdResult);
                
#pragma mark - 用户名验证
            NSDictionary *userCheck = @{
                @"userid":self.userNameTF.text};
            NSData *userData = [NSJSONSerialization dataWithJSONObject:userCheck options:NSJSONWritingPrettyPrinted error: nil];
            NSMutableData *userJsonData = [NSMutableData dataWithData:userData];
                
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:QUERYUSERID]];
            request.delegate = self;
            request.tag = kQueryUserIdRequest;
            
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            [request addRequestHeader:@"clentid" value: kAppBopKey];
            [request addRequestHeader:@"userid" value:self.userNameTF.text];
            [request addRequestHeader:@"chnflg" value:@"1" ];
            [request addRequestHeader:@"trandt" value: [MSUtil getyyyymmdd]];
            [request addRequestHeader:@"trantm" value:[MSUtil gethhmmss]];
            [request addRequestHeader:@"cookie" value: @""];
            [request addRequestHeader:@"uuid" value: @""];
            [request setRequestMethod:@"POST"];
            [request setPostBody:userJsonData];
            [request startAsynchronous];

            count = 1;
            }
        }
    }
}
- (void)sendRequest
{
    NSDictionary *headers = @{
                              @"clentid":kAppBopKey,
                              @"userid":self.userNameTF.text,
                              @"chnflg":@"1",
                              @"trandt":[MSUtil getyyyymmdd],
                              @"trantm":[MSUtil gethhmmss],
                              @"cookie":@""
                              };
    [self.userNameTF resignFirstResponder];
    [self.pwdAgainTF resignFirstResponder];
    
    BOCOPPayAuthorizeGetRandomNumDataRequest *request = [BOCOPPayAuthorizeGetRandomNumDataRequest requestWithHeaders:headers];
    
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        if (count==1) {
            self.serverRandId2 = result[@"randomid"];
            self.serverRandNum2 = result[@"random"];
        }else if(count==2){
            self.serverRandId = result[@"randomid"];
            self.serverRandNum = result[@"random"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *base64RandomCode = [self getBase64RandomCode:self.serverRandNum];
            if (count==1) {
                self.pwdTF.sipdelegate = self;
                self.pwdTF.randomeKey_S = base64RandomCode;
                [self.pwdTF getValue];
            }else if(count==2){
                self.pwdAgainTF.sipdelegate = self;
                self.pwdAgainTF.randomeKey_S = base64RandomCode;
                [self.pwdAgainTF getValue];
            }
        });
    }];
    [request onRequestFailWithError:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:[error userInfo][@"error_description"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.tag = 111;
        [alert show];

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
}

#pragma mark - 直接登录点击
-(void)directLoginAction:(UIButton *)sender
{
    GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                            @"LoginViewController",
                            @"LoginViewController4");
    
}
#pragma mark -
#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.userNameTF==textField) {
        [self.pwdTF becomeFirstResponder];
    }
    return YES;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.userNameTF ==textField) {
        if (![MSUtil validateUserName:self.userNameTF.text]) {
            self.popIV.frame = origRect;
            self.popLabel.frame= origRect;
            [self.view bringSubviewToFront:self.popIV];
            [self.view bringSubviewToFront:self.popLabel];
            [self performSelector:@selector(dismissPopViews) withObject:nil afterDelay:1.5];
        }else if([MSUtil validateMobile:self.userNameTF.text]){
            [MSUtil showHudMessage:@"用户名不能为以1开头的11位数" hideAfterDelay:1.5 uiview:self.view];
        }
    }
}

- (void)dismissPopViews
{
    self.popIV.frame = CGRectZero;
    self.popLabel.frame= CGRectZero;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 
#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"IIIIIIIIII ______ %@",dic);
    
    if (request.tag==kCheckPwdRequest) {
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            NSLog(@"JJJJJJJJJ   ____两次密码一致");
            NSDictionary *dic = @{
                                  @"usrid":self.userNameTF.text,
                                  @"usrnewpwd":self.pdResult,
                                  @"randomen":self.randomResult,
                                  @"randomid":self.serverRandId,
                                  @"enctyp":@"0"};
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error: nil];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:REGISTER_URL]];
            request.delegate = self;
            request.tag = kRegisterRequest;
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            [request addRequestHeader:@"clentid" value: kAppBopKey];
            [request addRequestHeader:@"userid" value:self.userNameTF.text];
            [request addRequestHeader:@"chnflg" value:@"1" ];
            [request addRequestHeader:@"trandt" value: [MSUtil getyyyymmdd]];
            [request addRequestHeader:@"trantm" value:[MSUtil gethhmmss]];
            [request addRequestHeader:@"cookie" value: @""];
            [request addRequestHeader:@"uuid" value: @""];
            [request setRequestMethod:@"POST"];
            [request setPostBody:tempJsonData];
            [request startAsynchronous];
        }else if([dic[@"msgcde"] isEqualToString:@"M317"]){
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
            [self showNBAlertWithAletTag:1 Title:@"温馨提示" content:dic[@"rtnmsg"] btnArray:arr];
        }else if([dic[@"msgcde"] isEqualToString:@"404"]){
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
            [self showNBAlertWithAletTag:2 Title:@"温馨提示" content:dic[@"rtnmsg"] btnArray:arr];
        }
    }else if(request.tag==kRegisterRequest){
        NSLog(@"LLLLLLLL______%@",dic);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        RegSuccessViewController *VC = [[RegSuccessViewController alloc]initWithNibName:@"RegSuccessViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
    }else if(request.tag==kQueryUserIdRequest){
        NSLog(@"RRRRRR_______%@___%@",dic,dic[@"rtnmsg"]);
        
        NSString *str = dic[@"msgcde"];
        
        if ([str isEqualToString:@"M301"]) {
#pragma mark -   //两次密码一致请求验证
            
            NSLog(@"_____%@",self.pdResult);
            NSLog(@"_____%@",self.pdResult2);
            NSLog(@"_____%@",self.serverRandNum);
            NSLog(@"_____%@",self.serverRandNum2);
            NSLog(@"_____%@",self.serverRandId);
            NSLog(@"_____%@",self.serverRandId2);
            
            NSDictionary *dic = @{
                                  @"pwd_old":self.pdResult,
                                  @"pwd_new":self.pdResult2,
                                  @"cyp_old":self.randomResult,
                                  @"cyp_new":self.randomResult2,
                                  @"randomid":self.serverRandId,
                                  @"randomid2":self.serverRandId2,
                                  @"enctyp":@"0"};
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error: nil];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:REG_CHECKTWOPASSWORD]];
            request.delegate = self;
            request.tag = kCheckPwdRequest;
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            [request addRequestHeader:@"clentid" value: kAppBopKey];
            [request addRequestHeader:@"userid" value:self.userNameTF.text];
            [request addRequestHeader:@"chnflg" value:@"1" ];
            [request addRequestHeader:@"trandt" value: [MSUtil getyyyymmdd]];
            [request addRequestHeader:@"trantm" value:[MSUtil gethhmmss]];
            [request addRequestHeader:@"cookie" value: @""];
            [request addRequestHeader:@"uuid" value: @""];
            [request setRequestMethod:@"POST"];
            
            [request setPostBody:tempJsonData];
            [request startAsynchronous];

        }else if([dic[@"userid"] isEqualToString:self.userNameTF.text]){
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
            [self showNBAlertWithAletTag:3 Title:@"温馨提示" content:dic[@"errormsg"] btnArray:arr];
        }
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"注册失败,请重试。" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    NSLog(@"GGGGGGG ______ %@",dic);
    if (request.tag==kCheckPwdRequest) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
        [self showNBAlertWithAletTag:4 Title:@"温馨提示" content:@"两次输入的密码不一致,请重新输入" btnArray:arr];
    }else if(request.tag==kRegisterRequest){
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
        [self showNBAlertWithAletTag:5 Title:@"温馨提示" content:@"注册失败,请重试" btnArray:arr];
    }

}
#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"d __ %d",buttonIndex );
    if ([alertView tag]==1||
        [alertView tag]==2||
        [alertView tag]==3||
        [alertView tag]==4||
        [alertView tag]==5)
    {
        [alertView close];
    }
}
//键盘收起
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
