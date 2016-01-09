//
//  FundCell.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-27.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "FundCell.h"
#import "BorderSetBtn.h"

@implementation FundCell

- (void)awakeFromNib
{
    // Initialization code
    self.imgView.layer.cornerRadius = 40;
    self.buyBtn.layer.cornerRadius = 4;
    self.btmView.backgroundColor = kRegBackGroudColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
