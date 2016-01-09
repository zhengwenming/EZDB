//
//  BOCOPPayDataRequest+HttpHeader.m
//  BOCOP
//
//  Created by 马 天龙 on 13-6-28.
//
//

#import "BOCOPPayDataRequest+HttpHeader.h"

@implementation BOCOPPayDataRequest(HttpHeader)

- (NSDictionary*)getBusinessRequestHeaderDictionary:(BOCOPPayAuthorizeInfo *)_authInfo
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMdd";
    
    NSDateFormatter *formatTime = [[NSDateFormatter alloc] init];
    formatTime.dateFormat = @"HHmmss";
//    if (_authInfo.userId && _authInfo.welCome) {
//        return @{@"clentid":_authInfo.clientId,@"userid":_authInfo.userId,@"acton":@"",@"chnflg":@"1",@"trandt":[formatDay stringFromDate:now],@"trantm":[formatTime stringFromDate:now]};
//    }
    NSString *dayStr = [formatDay stringFromDate:now];
    [formatDay release];
    NSString *timeStr = [formatTime stringFromDate:now];
    [formatTime release];
    if ([_authInfo.userId length]>0) {
        NSString *cookie=@"";
        if (_authInfo.Cookie.length>0) {
            cookie = _authInfo.Cookie;
        }
        return @{@"clentid":kAppBopKey,
                 @"userid":_authInfo.userId,
                 @"chnflg":@"1",
                 @"trandt":dayStr,
                 @"trantm":timeStr,
                 @"cookie":cookie,
                 @"uuid":@""};
    }
    else
    {
        return @{@"clentid":kAppBopKey,
                 @"userid":@"",
                 @"chnflg":@"1",
                 @"trandt":dayStr,
                 @"trantm":timeStr,
                 @"cookie":@"",
                 @"uuid":@""};
    }
    
}
@end
