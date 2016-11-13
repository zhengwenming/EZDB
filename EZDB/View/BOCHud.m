//
//  BOCHud.m
//  BOCLoadView
//
//  Created by wenming.zheng on 14-11-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BOCHud.h"

@implementation BOCHud

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mode =MBProgressHUDModeCustomView;
        self.square = YES;
        self.labelText = @"加载中...";

        self.rotationIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 60, 60)];

        self.rotationIV.image = [UIImage imageNamed:@"logo_1.png"];
        self.customView = self.rotationIV;
        
    }
    return self;
}
-(void)startAnimating{
    [self show:YES];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.duration = 4;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.repeatDuration = INT_MAX;
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    [self.rotationIV.layer addAnimation:rotateAnimation forKey:@"key"];

}
- (void)startAnimating:(NSTimeInterval)duration{
    [self show:YES];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"]; rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.duration = 4;
    rotateAnimation.repeatDuration = INT_MAX;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    [self.rotationIV.layer addAnimation:rotateAnimation forKey:@"key"];
}
-(void)stopAferDelay:(NSTimeInterval)delay{
    [self show:YES];
    [self hide:YES afterDelay:delay];
}
- (void)stopAnimating{
    [self hide:YES];
}

- (void)removeForever{
    [self removeFromSuperview];
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
