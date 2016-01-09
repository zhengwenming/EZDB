//
//  UnPayOrdersCell.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnPayOrdersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sumOfMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
- (IBAction)payButton:(id)sender;

@end
