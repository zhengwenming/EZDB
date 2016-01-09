//
//  RedeemDailureModel.h
//  EZDB
//
//  Created by tk on 14-11-25.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCOPPayBaseModelObject.h"

@interface RedeemDailureModel : BOCOPPayBaseModelObject
//订单号
@property(nonatomic,copy)NSString *failOrderNo;
//基金产品名称
@property(nonatomic,copy)NSString *fundName;
//基金产品代码
@property(nonatomic,copy)NSString *fundCode;
//交易时间
@property(nonatomic,copy)NSString *transactionData;
//交易类型
@property(nonatomic,copy)NSString *transactionType;
//订单状态
@property(nonatomic,copy)NSString *orderStatus;
//状态描述
@property(nonatomic,copy)NSString *statusDescription;
//赎回份额
@property(nonatomic,copy)NSString *redeemShare;
//绑定卡所属行
@property(nonatomic,copy)NSString *bankId;
//开户行
@property(nonatomic,copy)NSString *openBank;
//银行卡号
@property(nonatomic,copy)NSString *cardNo;
//银行卡唯一标识
@property(nonatomic,copy)NSString *cardSep;
@end
