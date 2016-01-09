//
//  NSTimer+Addition.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
