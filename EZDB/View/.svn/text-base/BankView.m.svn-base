//
//  BankView.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "BankView.h"

@implementation BankView
@synthesize logoIV,numLabel,typeLabel,holdNumLabel,holdTitleLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat imageWidth = 26;
        CGFloat imageHiget = 26;
        logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.frame.size.height/2-imageHiget/2, imageWidth, imageHiget)];
        logoIV.image = [UIImage imageNamed:@"ico_boc.png"];
        [self addSubview:logoIV];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8+logoIV.frame.size.width+18, self.frame.size.height/2-20, 90, 20)];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = @"中国银行";
//        titleLabel.textColor=K204GrayColor;
        [self addSubview:titleLabel];
        
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y+titleLabel.frame.size.height+2, titleLabel.frame.size.width-20, titleLabel.frame.size.height)];
        numLabel.font = [UIFont systemFontOfSize:13];
        numLabel.text = @"尾号4567";
//        numLabel.textColor=K204GrayColor;
        [self addSubview:numLabel];
        
        typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, numLabel.frame.origin.y, numLabel.frame.size.width+20, numLabel.frame.size.height)];
        typeLabel.text = @"水电缴费卡";
//        typeLabel.textColor=K204GrayColor;
        typeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:typeLabel];
        
        holdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, titleLabel.frame.origin.y, 95, 20)];
        holdTitleLabel.font = [UIFont systemFontOfSize:13];
        holdTitleLabel.text = @"持有额(元)";
        [self addSubview:holdTitleLabel];
        
        holdNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, holdTitleLabel.frame.origin.y+holdTitleLabel.frame.size.height+2, 95, 20)];
        holdNumLabel.font = [UIFont systemFontOfSize:15];
        holdNumLabel.text = @"6,000.00";
//        holdNumLabel.textColor=kBlackColor;
        
        [self addSubview:holdNumLabel];
        
        
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
