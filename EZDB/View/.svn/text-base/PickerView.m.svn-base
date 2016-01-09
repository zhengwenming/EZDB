//
//  PickerView.m
//  PickerDome
//
//  Created by wenming.zheng on 14-11-15.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //contentVeiw
        self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38)];
        self.contentView.backgroundColor = kRegBackGroudColor;
       
        [self addSubview:self.contentView];
        
        
        
        //titleLabel
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        if (kDeviceVersion<7.0) {
            [self.titleLabel setBackgroundColor:kRegBackGroudColor];
        }
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        

        
        //leftBtn
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBtn setImage:[UIImage imageNamed:@"ico_back_black.png"] forState:UIControlStateNormal];
        self.leftBtn.frame =CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y+4, self.contentView.frame.size.height, self.contentView.frame.size.height-8);
        [self.contentView addSubview:self.leftBtn];
        [self.contentView bringSubviewToFront:self.leftBtn];
        
        //rightBtn
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightBtn setImage:[UIImage imageNamed:@"ico_next.png"] forState:UIControlStateNormal];
        self.rightBtn.frame = CGRectMake(self.contentView.frame.origin.x+self.leftBtn.frame.size.width+5, self.leftBtn.frame.origin.y, self.leftBtn.frame.size.width, self.leftBtn.frame.size.height);
        [self.contentView addSubview:self.rightBtn];
        [self.contentView bringSubviewToFront:self.rightBtn];
        //sureBtn
        self.sureBtn  =  [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.sureBtn.titleLabel.textColor = [UIColor blackColor];
        self.sureBtn.frame = CGRectMake(self.contentView.frame.size.width-self.leftBtn.frame.size.width-20, self.leftBtn.frame.origin.y, self.leftBtn.frame.size.width+20, self.leftBtn.frame.size.height);
        [self.contentView addSubview:self.sureBtn];
    
        self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y+self.contentView.frame.size.height, self.contentView.frame.size.width, 192)];
        self.picker.showsSelectionIndicator = YES;
        [self addSubview:self.picker];
    }
    return self;
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
