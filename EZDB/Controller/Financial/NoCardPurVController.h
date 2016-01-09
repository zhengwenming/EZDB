//
//  NoCardPurVController.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

@class BorderSetBtn;

@interface NoCardPurVController : STViewController

/* 基金名称 */
@property (weak, nonatomic) IBOutlet UIButton *proName;

/* 立即绑定 */
@property (weak, nonatomic) IBOutlet BorderSetBtn *bindBtn;

@end
