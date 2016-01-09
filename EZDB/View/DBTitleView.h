//
//  DBTitleView.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"

@interface DBTitleView : UIView

@property(nonatomic,weak) UILabel *titleLabel;
@property(nonatomic,weak) MyButton *leftButton;
@property(nonatomic,weak) MyButton *rightButton;
@property(nonatomic,strong) UIImageView *titleBackgroundIV;


-(void)setBackgroundImage:(UIImage *)img withIOS7:(UIImage *)iOS7TitleImg;
@end
