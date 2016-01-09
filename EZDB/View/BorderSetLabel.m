//
//  BorderSetLabel.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BorderSetLabel.h"

@implementation BorderSetLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    self.font = [UIFont systemFontOfSize:14.0f];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 2.0f;
    self.layer.borderColor = kBorderBackgroudColor.CGColor;
    self.backgroundColor = kViewBackGroudColor;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
