//
//  CardCell.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BorderSetView;

@interface CardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/* 卡别名 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UIImageView *logoIV;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundCircleView;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@end
