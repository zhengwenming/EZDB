//
//  SubsSucViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/25.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

@interface SubsSucViewController : STViewController<PopViewContrlDelegate>

/* 交易金额 */
@property (copy, nonatomic) NSString *tranMoney;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

/* 交易日期 */
@property (copy, nonatomic) NSString *tranDate;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

/* 预计收益起始日期 */
@property (copy, nonatomic) NSString *profitStart;
@property (weak, nonatomic) IBOutlet UILabel *profitDate;

/* 预计收益到账日期 */
@property (copy, nonatomic) NSString *profitReach;
@property (weak, nonatomic) IBOutlet UILabel *profitGetLabel;


@end
