//
//  MyButton.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-22.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //    根据button的坐标 返回不同坐标 （左右图标宽度不同）
    NSInteger  x= self.frame.origin.x;
    if (x<100) {
        contentRect = CGRectMake(15, 0, 12, 20);
        
    }else{
        contentRect = CGRectMake(30, 0, 23, 20);
    }
    return contentRect;
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
