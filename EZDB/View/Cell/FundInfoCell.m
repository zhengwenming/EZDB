//
//  FundInfoCell.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "FundInfoCell.h"

@implementation FundInfoCell

- (void)awakeFromNib
{
    [self setBackgroundColor:[UIColor whiteColor]];
    if (kDeviceVersion<7.0) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
