//
//  FundDetailModel.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FundDetailModel : BOCOPPayBaseModelObject

/* 货币基金万份收益 */
@property (nonatomic,copy) NSString *fundIncome;

/* 基金代码 */
@property (nonatomic,copy) NSString *fundCode;

/* 基金简称 */
@property (nonatomic,copy) NSString *fnSNam;

/* 基金全称 */
@property (nonatomic,copy) NSString *fnLNam;

/* 注册登记机构代码 */
@property (nonatomic,copy) NSString *regCod;

/* 注册登记机构名称 */
@property (nonatomic,copy) NSString *regNam;

/* 基金管理公司代码 */
@property (nonatomic,copy) NSString *admCod;

/* 基金管理公司名称 */
@property (nonatomic,copy) NSString *admNam;

/* 产品运行状态 */
@property (nonatomic,copy) NSString *fnStat;

/* 收费方式 */
@property (nonatomic,copy) NSString *feeMod;

/* 申购上限 */
@property (nonatomic,copy) NSString *buyUplim;

/* 申购下限 */
@property (nonatomic,copy) NSString *buyLowLim;

/* 赎回上限 */
@property (nonatomic,copy) NSString *saleUplim;

/* 赎回下限 */
@property (nonatomic,copy) NSString *saleLowLim;

/* 货币基金七日年化收益 */
@property (nonatomic,copy) NSString *yield;

/* 净值  */
@property (nonatomic,copy) NSString *nav;

/* 货币基金万份收益正负  */
@property (nonatomic,copy) NSString *fundIncomeFlag;

/* 最近一年货币基金年收益率  */
@property (nonatomic,copy) NSString *fundYearIncomeRate;

/* 最近一年货币基金年收益率正负 */
@property (nonatomic,copy) NSString *fundYearIncomeRateFlag;

@end
