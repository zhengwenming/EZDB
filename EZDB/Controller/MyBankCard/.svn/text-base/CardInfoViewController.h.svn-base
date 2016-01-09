//
//  CardInfoViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

typedef void(^completeBlock) (id obj);

@interface CardInfoViewController : STViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    completeBlock changeCardName;
}

@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardTypeTF;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *singleLabel;
@property (weak, nonatomic) IBOutlet UILabel *everydayLabel;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIImageView *logoIV;
@property (weak, nonatomic) IBOutlet UIView *singleView;
@property (weak, nonatomic) IBOutlet UIView *dayView;

/** 银行标识 */
@property (retain,nonatomic)NSString *logoString;
@property (retain,nonatomic)NSString *typeString;
@property (retain,nonatomic)NSString *NumberString;

/** 上个界面未处理的cardNo*/
@property (retain,nonatomic)NSString *cardNo;


-(id)initWithBlock:(completeBlock)back;

@end
