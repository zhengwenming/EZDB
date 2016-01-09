//
//  DBTitleView.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "DBTitleView.h"

@implementation DBTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView * aIV= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        self.titleBackgroundIV = aIV;
        aIV.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleBackgroundIV];
    
        // Initialization code
        UILabel * aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, IOS7DELTA+5, kScreenWidth, 34)];
        self.titleLabel = aLabel;
        self.titleLabel.text = @"";
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont boldSystemFontOfSize:18];

        [self addSubview:self.titleLabel];
        
//检查image
        UIImage *rightImage = [UIImage imageNamed:@""];
        MyButton *rightButton = [[MyButton alloc]initWithFrame:CGRectMake(kScreenWidth-70, IOS7DELTA+10, 90, 44)];
        [self addSubview:rightButton];
        [rightButton imageRectForContentRect:CGRectMake(0, 0, 18, 17)];
        [rightButton setBackgroundImage:rightImage forState:UIControlStateNormal];
        self.rightButton = rightButton;
        
        UIImage *leftImage = [UIImage imageNamed:@""];
        MyButton *leftButton = [[MyButton alloc]initWithFrame:CGRectMake(0, IOS7DELTA+10, 90, 44)];
        [leftButton imageRectForContentRect:CGRectMake(0, 0, 12, 20)];
        [leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
        [self addSubview:leftButton];
        self.leftButton = leftButton;
    }
    return self;
}
-(void)setBackgroundImage:(UIImage *)img withIOS7:(UIImage *)iOS7TitleImg;
{
    if (kDeviceVersion>= 7.0){
        if(!iOS7TitleImg){
            [self.titleBackgroundIV setImage:img];
            
        }else{
            self.titleBackgroundIV.image = iOS7TitleImg;
        }
    }else{
        self.titleBackgroundIV.image = img;
    }
}
- (void)dealloc
{
    [self.titleLabel removeFromSuperview];
    self.titleLabel = nil;
    
    [self.titleBackgroundIV removeFromSuperview];
    self.titleBackgroundIV = nil;
    
    
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
