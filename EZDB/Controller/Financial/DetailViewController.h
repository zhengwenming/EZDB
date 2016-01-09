//
//  DetailViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-28.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

typedef enum {
    MyPensionTotal = 0,   //累计收益
    MypensionYield = 1,   //七日年化
    MyPensionGains = 2,   //万份收益
} MyPensionType;

@class ChartView;

@interface DetailViewController : STViewController

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSString *fundCode;
@property (nonatomic,copy) NSString *fundName;
@property (nonatomic,copy) NSString *sProRate;
@property (nonatomic,copy) NSString *tProfit;


/** 最大收益 */
@property (nonatomic, assign) double maxTotald;

/** 最大7日年化 */
@property (nonatomic, assign) double maxYield;

/** 最大年化 */
@property (nonatomic, assign) double maxGains;

/** 累计收益 */
@property (nonatomic,copy)  NSString *totaldividend;

/** 查询类型 */
@property (nonatomic,assign) MyPensionType myPensionType;

/** 显示的金额 */
@property (nonatomic,copy) NSString *showMoney;



@end
