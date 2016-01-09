//
//  QueryGainsInfo.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-13.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "QueryGainsInfo.h"

@implementation QueryGainsInfo

- (NSDictionary *)attributeMapDictionary
{
    return @{@"fundIncome":@"fundIncome",
             @"fundIncomeFlag":@"fundIncomeFlag",
             @"navDate":@"navDate",
             @"yield":@"yield",
             @"yieldFlag":@"yieldFlag"};
}
@end
