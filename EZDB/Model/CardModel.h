//
//  CardModel.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-31.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : BOCOPPayBaseModelObject

@property (nonatomic,copy) NSString *cardType;
@property (nonatomic,copy) NSString *cardNO;

/** 银行标识 */
@property (nonatomic,copy) NSString *bankLogo;

@property (nonatomic,copy) NSString *cardMobile;
@property (nonatomic,copy) NSString *bankCode;

/** 卡号后四位 */
@property (nonatomic,copy) NSString *cardTailNo;

/** 开户行 */
@property (nonatomic,copy) NSString *openBank;

/** 卡别名 */
@property (nonatomic,copy) NSString *actName;

/** 卡唯一标识 */
@property (nonatomic,copy) NSString *cardSeq;

@end
