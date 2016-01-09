//
//  LoginViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-14.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "LoginViewController.h"
#import "RegViewController.h"
#import "PerCenterVController.h"
#import "QueryVCPPwdRequest.h"
#import "BorderSetBtn.h"


typedef enum : NSUInteger {
    kForgetButtonClick = 100,
    kRememberButtonClick,
    kLoginButtonClick,
    kRegisterButtonClick
} kButtonPress;

@interface LoginViewController ()
{
    __weak IBOutlet UIView *_pwdView;
    __weak IBOutlet UIView *_userView;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger)index
{
    switch (index) {
        case 1:{
            if ([BOCOPLogin sharedInstance].isLogin==NO) {
                [self backHomeVc];
            }else{
                [self backHomeVc];
            }
        }
            break;
        case 2:{
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"d __ %d",buttonIndex );
    if ([alertView tag]==1) {         //忘记密码
        [alertView close];
        if (buttonIndex==0) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://open.boc.cn"]];
        }else if (buttonIndex==1) {
        }
    }else if ([alertView tag]==2){    //密码错误
        [alertView close];
    }else if ([alertView tag]==3){    //M399
        [alertView close];
    }
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutSubView];
    [self setTextField];
    [self setNavView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}

#pragma mark -
- (void)layoutSubView
{
    _userView.layer.borderWidth = 1.0f;
    _userView.layer.cornerRadius = 5.0f;
    _userView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _pwdView.layer.borderWidth = 1.0f;
    _pwdView.layer.cornerRadius = 5.0f;
    _pwdView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _regBtn.backgroundColor = kRegBackGroudColor;
    _loginBtn.backgroundColor = kBtnBackGroudColor;

}
- (void)setNavView
{
    [self setNavBarWithtitle:@"登录" superView:self.view backImg:kNavBackImgName homeImg:nil];
    if (kDeviceVersion>=7.0) {
       
    }else{
        self.upView.frame = CGRectMake(0, 77, kScreenWidth, 108);
        self.downView.frame = CGRectMake(0, 193, kScreenWidth, 157);
    }
}

- (void)setTextField
{
    self.bInputYouUserName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    self.bInputYouUserName.delegate = self;
    self.bInputYouUserName.returnKeyType = UIReturnKeyDone;
    self.bInputYouUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.bInputYouPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.bInputYouPassword.secureTextEntry = YES;
    self.bInputYouPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.bInputYouPassword.placeholder = @"请输入登录密码";
    self.bInputYouPassword.returnKeyType = UIReturnKeyDone;
    self.bInputYouPassword.backgroundColor = [UIColor clearColor];
    self.bInputYouPassword.clearsOnBeginEditing = YES;
    self.bInputYouPassword.font = [UIFont systemFontOfSize:14];
    self.bInputYouPassword.borderStyle = UITextBorderStyleNone;
    self.bInputYouPassword.randomeKey_S = @"MDAwMDAwMDAwMDAwMDk4Nw==";
    self.bInputYouPassword.passwordMaxLength = 15;
    self.bInputYouPassword.passwordMinLength = 6;
    self.bInputYouPassword.outputValueType = 2;
    self.bInputYouPassword.passwordRegularExpression = @"[a-zA-Z0-9]*";
    self.bInputYouPassword.sipdelegate = self;

}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.bInputYouUserName == textField){
        if(string.length <=1 &&
           (textField.text.length >=20 &&
            ![string isEqualToString:@""] )){
            return NO;
    }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:MayUsedCharacter ] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest){
            [self.bInputYouUserName resignFirstResponder];
            return NO;
        }
        return basicTest;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.bInputYouUserName == textField){
        [self.bInputYouUserName becomeFirstResponder];
    }
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.bInputYouPassword == textField){
        [self.bInputYouPassword resignFirstResponder];
    }
}

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
#endif
{}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//键盘收起
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
