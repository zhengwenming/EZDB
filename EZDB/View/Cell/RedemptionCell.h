//
//  RedemptionCell.h
//  EZDB
//
//  Created by tk on 14-11-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedemptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *redemptionName;
@property (weak, nonatomic) IBOutlet UILabel *redemptionState;

@property (weak, nonatomic) IBOutlet UILabel *redemptionTime;
@property (weak, nonatomic) IBOutlet UILabel *redemptionBank;
@property (weak, nonatomic) IBOutlet UILabel *redemptionMoney;

@end
