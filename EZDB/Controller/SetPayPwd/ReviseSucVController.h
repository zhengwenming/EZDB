//
//  RiveseSucVController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-29.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"
#import "NavView.h"

@interface ReviseSucVController : STViewController

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *labelStr;
@property (weak, nonatomic) IBOutlet UILabel *sucLabel;

@end
