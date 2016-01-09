//
//  EZDBAppDelegate.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-14.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarViewController;

@interface EZDBAppDelegate : UIResponder <UIApplicationDelegate,NSURLConnectionDataDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) EZDBAppDelegate *delegate;

@property (strong, nonatomic) TabBarViewController *tabBarCtl;

@property (assign, nonatomic) BOOL isIphone5ReSize;

@property (assign, nonatomic) BOOL isExisted;

@property (assign, nonatomic) BOOL isConnected;

@property (copy, nonatomic) NSString *appUrl;

+ (EZDBAppDelegate*)appDelegate;

@end
