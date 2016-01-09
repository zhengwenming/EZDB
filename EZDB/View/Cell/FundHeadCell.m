//
//  FundHeadCell.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "FundHeadCell.h"

@implementation FundHeadCell

- (void)awakeFromNib
{
    // Initialization code
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.chView setBackgroundColor:[UIColor clearColor]];
    [self.daysBtn setSelected:YES];
    [self.proRateBtn setSelected:YES];
    [self.sProRate setTextColor:kBLueColor ];
    [self.tProfit setTextColor:K204GrayColor];

    //万分收益
    [self.proRateBtn setTitleColor:kBLueColor forState:UIControlStateSelected];
    [self.proRateBtn setTitleColor:K204GrayColor forState:UIControlStateNormal];
    [self.profitBtn setTitleColor:kBLueColor forState:UIControlStateSelected];
    [self.profitBtn setTitleColor:K204GrayColor forState:UIControlStateNormal];

    [self.profitBtn setBackgroundImage:[UIImage imageNamed:@"profit_Sele"] forState:UIControlStateNormal];
    [self.profitBtn setBackgroundImage:[UIImage imageNamed:@"profit_Nor"] forState:UIControlStateSelected];
    //7天年化收益率

    [self.proRateBtn setBackgroundImage:[UIImage imageNamed:@"profit_Sele"] forState:UIControlStateNormal];
    [self.proRateBtn setBackgroundImage:[UIImage imageNamed:@"profit_Nor"] forState:UIControlStateSelected];
    //7日
    [self.daysBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.daysBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.daysBtn setBackgroundImage:[UIImage imageNamed:@"button_nor"] forState:UIControlStateNormal];
    [self.daysBtn setBackgroundImage:[UIImage imageNamed:@"button_sec"] forState:UIControlStateSelected];
    //1个月
    [self.oneMonth setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.oneMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.oneMonth setBackgroundImage:[UIImage imageNamed:@"button_nor"] forState:UIControlStateNormal];
    [self.oneMonth setBackgroundImage:[UIImage imageNamed:@"button_sec"] forState:UIControlStateSelected];
    //2个月
    [self.twoMonth setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.twoMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.twoMonth setBackgroundImage:[UIImage imageNamed:@"button_nor"] forState:UIControlStateNormal];
    [self.twoMonth setBackgroundImage:[UIImage imageNamed:@"button_sec"] forState:UIControlStateSelected];

    if (kDeviceVersion<7.0) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        CGRect rect = self.contentView.frame;
        rect.origin.x -= 20;
        self.frame = rect;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    [self _setupExampleGraph];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotice:) name:@"btnSelectNotice" object:nil];

}


- (void)getNotice:(NSNotification *)notice
{

    [self.graph reset];
    UIButton *btn = (UIButton *)[notice object];
    btn.selected = YES;
    switch (btn.tag) {
        case 2:{
            self.profitBtn.selected = NO;
            self.tProfit.textColor = K204GrayColor;
            self.sProRate.textColor = kBLueColor;
            self.data = @[@[@620, @650, @580, @620, @540, @400, @0]];

            self.graph.dataSource = self;
            self.graph.lineWidth = 3.0;
            self.graph.valueLabelCount = 6;
            [self.graph draw];
        }
            break;
        case 3:{
            self.data = @[@[@180, @90, @50, @160, @100, @40, @110]];
            self.graph.dataSource = self;
            self.graph.lineWidth = 3.0;
            self.graph.valueLabelCount = 6;
            [self.graph draw];
            self.proRateBtn.selected = NO;
            self.sProRate.textColor = K204GrayColor;
            self.tProfit.textColor = kBLueColor;
        }
            break;
        case 4:{//7天
            self.data = @[@[@40, @20, @60, @100, @60, @20, @60]];
            self.labels = @[@"11-01", @"11-02", @"11-03", @"11-04", @"11-05", @"11-06", @"11-07"];
            self.graph.dataSource = self;
            self.graph.lineWidth = 3.0;
            self.graph.valueLabelCount = 6;
            [self.graph draw];
            self.oneMonth.selected = NO;
            self.twoMonth.selected = NO;
        }
            break;
        case 5:{//一个月
            self.data = @[@[@120, @150, @80, @120, @140, @100, @0]];
            self.labels = @[@"11-01", @"11-06", @"11-11", @"11-16", @"11-21", @"11-26", @"11-30"];
            self.graph.dataSource = self;
            self.graph.lineWidth = 3.0;
            self.graph.valueLabelCount = 6;
            [self.graph draw];
            self.daysBtn.selected = NO;
            self.twoMonth.selected = NO;
        }
            break;
        case 6:{//2个月
            self.data = @[@[@80, @50, @40, @160, @100, @40, @110]];
            self.labels = @[@"11-01", @"11-10", @"11-19", @"11-28", @"12-08", @"12-18", @"12-30"];
            self.graph.dataSource = self;
            self.graph.lineWidth = 3.0;
            self.graph.valueLabelCount = 6;
            [self.graph draw];

            self.oneMonth.selected = NO;
            self.daysBtn.selected = NO;
            }
            break;
            
        default:
            break;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)_setupExampleGraph {
    
    self.data = @[@[@20, @50, @28, @60, @40, @140, @80]];
    
    self.labels = @[@"11-01", @"11-02", @"11-03", @"11-04", @"11-05", @"11-06", @"11-07"];
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    self.graph.valueLabelCount = 6;
    [self.graph draw];
}
#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return 1;
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_alizarinColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1.5, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}

#pragma mark -
- (IBAction)cellBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(btnClick:withObject:withSender:)]) {
        [_delegate btnClick:sender.tag withObject:self withSender:sender];
    }
}

@end
