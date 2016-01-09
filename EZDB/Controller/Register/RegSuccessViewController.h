//
//  RegSuccessViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BorderSetBtn;

@interface RegSuccessViewController : STViewController

@property (strong, nonatomic) IBOutlet UIImageView *remView;
@property (weak, nonatomic) IBOutlet BorderSetBtn *setPayPwdBtn;
@property (weak, nonatomic) IBOutlet UILabel *_congratulationLabel;


@end
