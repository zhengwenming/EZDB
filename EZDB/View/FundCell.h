//
//  FundCell.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-27.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BorderSetBtn;

@interface FundCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet BorderSetBtn *buyBtn;

@property (weak, nonatomic) IBOutlet UIView *sVIew;

@property (weak, nonatomic) IBOutlet UILabel *proRate;

@property (weak, nonatomic) IBOutlet UILabel *saleMoney;

@property (weak, nonatomic) IBOutlet UILabel *profit;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UILabel *fundCode;

@property (weak, nonatomic) IBOutlet UIView *btmView;


@end
