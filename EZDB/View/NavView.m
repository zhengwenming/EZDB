//
//  NavView.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "NavView.h"

@implementation NavView

- (id)initWithFrame:(CGRect)frame navTitle:(NSString *)title lBtnImg:(NSString *)imgStrBack rBtnImg:(NSString *)imgStrHome
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (kDeviceVersion>=7.0) {
            self.titleView = [[DBTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        }else{
            self.titleView = [[DBTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        }
//        self.titleView.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.titleView.backgroundColor = [UIColor blackColor];

        self.titleView.titleLabel.text = title;
     
        [self.titleView.leftButton setImage:[UIImage imageNamed:imgStrBack] forState:UIControlStateNormal]; // @"ico_back.png"
        [self.titleView.rightButton setImage:[UIImage imageNamed:imgStrHome] forState:UIControlStateNormal]; // @"ico_home.png"
        [self.titleView.leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        self.titleView.leftButton.tag = 1;
        [self.titleView.rightButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        self.titleView.rightButton.tag = 2;
        [self addSubview:self.titleView];

    }
    return self;
}
- (void)backAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(popViewContrl:)]) {
        [_delegate popViewContrl:sender.tag];
    }
}
@end
