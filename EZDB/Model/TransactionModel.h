//
//  TransactionModel.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-25.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCOPPayBaseModelObject.h"

@interface TransactionModel : BOCOPPayBaseModelObject
//订单列表数量
@property(nonatomic,copy)NSString *orderNum;
//主站订单号
@property(nonatomic,copy)NSString *orderNo;
//基金产品代码
@property(nonatomic,copy)NSString *fundCode;
//基金产品名称
@property(nonatomic,copy)NSString *fundName;
//交易时间
@property(nonatomic,copy)NSString *transactionDate;
//交易类型
@property(nonatomic,copy)NSString *transactionType;
//订单状态
@property(nonatomic,copy)NSString *orderStatus;

//状态描述
@property(nonatomic,copy)NSString *statusDescription;

//绑定卡所属行
@property(nonatomic,copy)NSString *bankId;
//开户行
@property(nonatomic,copy)NSString *openBank;
//银行卡号
@property(nonatomic,copy)NSString *cardNo;
//银行卡唯一标识
@property(nonatomic,copy)NSString *cardSeq;
//赎回份额
@property(nonatomic,copy)NSString *redeemShare;
//申购金额
@property(nonatomic,copy)NSString *subscribeAmount;

@end
