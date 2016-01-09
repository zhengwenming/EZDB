//
//  AddNewCardDataRequest.m
//  BOCOP
//
//  Created by 马 天龙 on 13-7-11.
//
//

#import "AddNewCardDataRequest.h"

@implementation AddNewCardDataRequest
-(NSString*)getURLString
{
    return  BOCOPPAY_URL_ADDNEWCARD;
}

-(BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodPut;
}
@end
