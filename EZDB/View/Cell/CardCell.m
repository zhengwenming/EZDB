//
//  CardCell.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)awakeFromNib
{
    self.contentView.backgroundColor = kViewBackGroudColor;
    self.bigView.layer.cornerRadius = 5.0f;
    self.bigView.backgroundColor = kRegBackGroudColor;
    self.bigView.layer.borderWidth=0.5;
    self.bigView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _backgroundCircleView.layer.cornerRadius=22.0f;
    if (IS_IPHONE4) {
       CGRect rect = self.bigView.frame;
        rect.size.height -= 10;
        self.bigView.frame = rect;
    }
//    self.logoIV.frame = CGRectMake(15, 10, 160, 45);
    // Initialization code
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
