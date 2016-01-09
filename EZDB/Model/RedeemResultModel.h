//
//  RedeemResultModel.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/24.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCOPPayBaseModelObject.h"

@interface RedeemResultModel : BOCOPPayBaseModelObject
//主站订单号
@property(nonatomic,copy)NSString * orderNO;

//预计到账日期
@property(nonatomic,copy)NSString * backAcctDate;

//订单状态
@property(nonatomic,copy)NSString * orderStatus;

//状态描述
@property(nonatomic,copy)NSString * transactionDate;

//错误原因
@property(nonatomic,copy)NSString * confirmWorkDay;

//订单所属交易日
@property(nonatomic,copy)NSString * totalVol;

//确认工作日
@property(nonatomic,copy)NSString * availableVol;

//用户当前总份额
@property(nonatomic,copy)NSString * frozenVol;

//用户当前可用份额
@property(nonatomic,copy)NSString * statusDescription;

//用户当前冻结份额
@property(nonatomic,copy)NSString * errorReason;

//Json示例：
//{
//    "orderNo": "R20141101123423111",
//    "backAcctDate": "20141114",
//    "orderStatus": "0",
//    "transactionDate": "20150101",
//    "confirmWorkDay": "20150101",
//    "totalVol": "",
//    "availableVol": "",
//    "frozenVol": "",
//    "statusDescription": "",
// 	"errorReason": ""
//    
//}

@end
