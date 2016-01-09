//
//  NoticeViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-1.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "STViewController.h"

@interface NoticeViewController : STViewController

@property (nonatomic,copy) NSString *noticeId;

@property (weak, nonatomic) IBOutlet UILabel *noticeTitle;

@end
