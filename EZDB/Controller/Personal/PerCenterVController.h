//
//  PerCenterVController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WmPickerViewController.h"

@class WmPickerViewController;

@interface PerCenterVController : STViewController<
                                    UIActionSheetDelegate,
                                    UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate,
                                    ASIHTTPRequestDelegate,
                                    NSURLConnectionDataDelegate,
                                    WmImagePickerDelegate,
                                    PopViewContrlDelegate>


/* 名字 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/* 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/* 密码管理 */
@property (weak, nonatomic) IBOutlet UIButton *pwdManBtn;
/* 待处理交易 */
@property (weak, nonatomic) IBOutlet UIButton *myBankCard;
/* 系统中心 */
@property (weak, nonatomic) IBOutlet UIButton *systemBtn;
@property (weak, nonatomic) IBOutlet UIButton *tansitionBtn;

- (IBAction)RedeBtn:(id)sender;
- (IBAction)traBtn:(id)sender;

//用户名
@property (nonatomic,copy) NSString *username;
//支付密码按钮名
@property (nonatomic,copy) NSString *payPwdName;
//是否设置支付密码
@property (nonatomic,assign) BOOL isSet;

@end
