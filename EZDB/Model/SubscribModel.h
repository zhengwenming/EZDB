//
//  SubscribModel.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/21.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCOPPayBaseModelObject.h"

@interface SubscribModel : BOCOPPayBaseModelObject

/** 主站订单号 */
@property (nonatomic,copy) NSString *orderNo;

/** 订单状态 */
@property (nonatomic,copy) NSString *orderStatus;

/** 状态描述 */
@property (nonatomic,copy) NSString *statusDescription;

/** 订单所属交易日 */
@property (nonatomic,copy) NSString *transactionDate;

/** 份额确认工作日 */
@property (nonatomic,copy) NSString *confirmWorkDay;

/** 收益起始日期 */
@property (nonatomic,copy) NSString *incomeStartDate;

/** 错误原因 */
@property (nonatomic,copy) NSString *errReason;


@end
