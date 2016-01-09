//
//  BOCPayRequestManager.h
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BOCOPPayDataRequest;

@interface BOCOPPayRequestManager : NSObject{
    NSMutableArray *_requests;
}
/**
 单列初始化
 @param  无
 @return 没有返回值
 */
+ (BOCOPPayRequestManager *)sharedManager;

/**
 request 天假;
 @param  无;
 @return 无;
 */
- (void)addRequest:(BOCOPPayDataRequest*)request;

/**
 request 移除;
 @param  无;
 @return 无;
 */
- (void)removeRequest:(BOCOPPayDataRequest*)request;

/**
 request 清空;
 @param  无;
 @return 无;
 */
- (void)cleanAllRequest;
@end
