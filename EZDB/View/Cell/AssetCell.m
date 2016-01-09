//
//  AssetCell.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "AssetCell.h"

@implementation AssetCell

- (void)awakeFromNib
{


    self.titleLabel.textColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
