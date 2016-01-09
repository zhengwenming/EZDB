//
//  CustInfoModel.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-3.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustInfoModel : BOCOPPayBaseModelObject

/** 用户ID */
@property (nonatomic,copy) NSString *userid;

/** 证件类型 */
@property (nonatomic,copy) NSString *idtype;

/** 证件号码 */
@property (nonatomic,copy) NSString *idno;

/** 客户姓名 */
@property (nonatomic,copy) NSString *cusname;

/** 手机号 */
@property (nonatomic,copy) NSString *mobileno;

/** 错误原因 */
@property (nonatomic,copy) NSString *errReason;

/** 核心客户号 */
@property (nonatomic,copy) NSString *cusid;

@end
