//
//  TaldividendInfo.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-13.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//  累计收益明细

#import "BOCOPPayBaseModelObject.h"

@interface TaldividendInfo : BOCOPPayBaseModelObject

/** 收益额*/
@property (nonatomic, copy) NSString *dividend;

/** 日期 */
@property (nonatomic,copy) NSString *divdate;

@end
