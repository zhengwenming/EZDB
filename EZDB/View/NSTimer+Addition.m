//
//  NSTimer+Addition.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-30.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
- (void)pauseTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}
- (void)resumeTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
