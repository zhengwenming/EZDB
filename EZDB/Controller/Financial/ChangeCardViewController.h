//
//  ChangeCardViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
// 换卡 页面
//调用此页面 需传入传值用 6个字段的值


#import "STViewController.h"
@interface ChangeCardViewController : STViewController

@property (strong, nonatomic) IBOutlet UIView *changeCardInfoView;
@property (weak, nonatomic) IBOutlet UILabel *fundName; //基金名称
@property (weak, nonatomic) IBOutlet UILabel *sumOfMoney;//购买金额
@property (weak, nonatomic) IBOutlet UILabel *oldCardInfo;//原卡信息
@property (weak, nonatomic) IBOutlet UIButton *chooseCardButton;//选择新银行卡 按钮
@property (weak, nonatomic) IBOutlet UIButton *isChangeAllCard;//是否替换所有

- (IBAction)isChangeAllCardAction:(id)sender;// 是否替换所有点击事件
- (IBAction)chioceNewRedeemCard:(id)sender;//选择新银行卡 点击事件
- (IBAction)changeCardSubmitClick:(id)sender;//确定按钮事件


//传值用
@property(retain,nonatomic)NSString * fundNameStr;// 基金名称
@property(retain,nonatomic)NSString * sumMoneyStr;// 购买金额
@property(retain,nonatomic)NSString * cardSeqStr;//  旧银行卡信息 eg:"中国银行 尾号1234"

@property(retain,nonatomic)NSString * failOrderNo;//失败订单号
@property(retain,nonatomic)NSString * cardSeq;//旧银行卡唯一标识
@property(retain,nonatomic)NSString * nCardSeq;//新银行卡唯一标识

@end
