//
//  DetailHelpViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-18.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHelpViewController : STViewController

@property (strong ,nonatomic) NSString *titleString;
@property (strong ,nonatomic) NSString *contentString;

@property (strong ,nonatomic) UILabel *titleLabel;
@property (strong ,nonatomic) UILabel *contentLabel;
@property (strong ,nonatomic) UILabel *bottomLabel;


@end
