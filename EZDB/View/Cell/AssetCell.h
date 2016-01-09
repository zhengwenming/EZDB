//
//  AssetCell.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *yesdayProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyInCtrl;
@property (weak, nonatomic) IBOutlet UILabel *sevenProfitLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *redeemBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalProfitLabel;
@end
