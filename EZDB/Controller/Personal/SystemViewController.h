//
//  SystemViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

@interface SystemViewController : STViewController

/* new字样 */
@property (weak, nonatomic) IBOutlet UIImageView *nVersionView;

@property (weak, nonatomic) IBOutlet UIView *logOutView;

@property (weak, nonatomic) IBOutlet UILabel *version;

@end
