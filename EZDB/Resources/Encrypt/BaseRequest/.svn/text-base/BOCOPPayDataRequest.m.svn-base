//
//  BOCOPPayDataRequest.m
//
//  Based on OAuth 2.0
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BOCOPPayDataRequest.h"
#import "JSONKit.h"
#import "BOCOPPay.h"
#import "BOCOPPayRequestManager.h"
#import "BOCOPPayDebug.h"
#import "BOCOPLogin.h"
#import "EZDBAppDelegate.h"


@interface BOCOPPayDataRequest () <UIApplicationDelegate>
{
    NSURLConnection                 *_connection;
    NSMutableData                   *_responseData;
    NSString *_responseString;
    
    void (^_onRequestFailWithError)(NSError *);
    void (^_onRequestDidFinishLoadingWithResult)(NSDictionary *);
}

@end


@implementation BOCOPPayDataRequest


#pragma mark - Lifecycle methods

- (void)dealloc
{
    BOCOPDINFO(@"request is released");
    [_params release];
    [_postJSON release];
    [_headers release];
    [_responseString release];
    
    [_responseData release];
    
    [_connection cancel];
    [_connection release];
    [_onRequestFailWithError release];
    [_onRequestDidFinishLoadingWithResult release];
    [super dealloc];
}

#pragma mark - Private Methods

- (NSString*)encodeURL:(NSString *)string
{
//	NSString *newString = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease];
    
    if (string) {
        return string;
    }
    return @"";
    
//    NSString *newString = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease];
//	if (newString) {
//		return newString;
//	}
//	return @"";
}

- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString
{
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSMutableData *)getPostBody
{
    NSMutableData *body = [NSMutableData data];
    [self appendUTF8Body:body dataString:(_postJSON?_postJSON:@"")];

    return body;
}
- (void)handleResponseData:(NSData *)data
{
    [_responseString release];
    _responseString = nil;
    _responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    BOCOPDINFO(@"response string:%@",_responseString);
    
    NSError *error = nil;
	NSDictionary *result = [self parseJSONData:data error:&error];

	if (error){
		[self failedWithError:error];
	
    }else{
        if (result[@"msgcde"]){
                BOCOPDINFO(@"%@",result[@"msgcde"]);
                if (result[@"welcome"]) {
                    if (_onRequestDidFinishLoadingWithResult){
                        _onRequestDidFinishLoadingWithResult(result);
                    }
                }else{
                    NSString *messageCode;
                    if ([result[@"msgcde"] isKindOfClass:[NSNumber class]]) {
                        messageCode = [result[@"msgcde"] stringValue];
                    }else{
                        messageCode = result[@"msgcde"];
                    }
                    NSDictionary *errorInfo;
                    if (result[@"rtnmsg"]) {
                        errorInfo = @{@"error_code":messageCode,@"error_description":result[@"rtnmsg"]};
                    }else{
                        errorInfo = @{@"error_code":messageCode,@"error_description":@""};
                    }
                    
                    NSError *error = [[[NSError alloc] initWithDomain:kBOCOPPaySDKErrorDomain
                                                                 code:BOCOPPaySDKErrorCodeServerError
                                                             userInfo:errorInfo] autorelease];
                    
                    [self failedWithError:error];
                }
            }else{
                if (_onRequestDidFinishLoadingWithResult){
                    _onRequestDidFinishLoadingWithResult(result);
                }
            }
        }
}

- (id)parseJSONData:(NSData *)data error:(NSError **)error
{
    NSError *parseError = nil;
    id result = [[JSONDecoder decoder] objectWithData:data error:&parseError];
    
    BOCOPDINFO(@"BOCOPDINFO result is:%@",result);
    
	if (parseError && (error != nil)){
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  parseError, @"error",
                                  @"Data parse error", NSLocalizedDescriptionKey, nil];
        *error = [self errorWithCode:1
                            userInfo:userInfo];
	}
	
	return result;
}

- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo
{
    return [NSError errorWithDomain:kBOCOPPaySDKErrorDomain code:code userInfo:userInfo];
}

- (void)failedWithError:(NSError *)error
{
    if (_onRequestFailWithError) {
        _onRequestFailWithError(error);
    }
}


- (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
    NSURL* parsedURL = [NSURL URLWithString:baseURL];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
    
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator])
    {
        if (([[params objectForKey:key] isKindOfClass:[UIImage class]])
            ||([[params objectForKey:key] isKindOfClass:[NSData class]])){
            continue;
        }
        
        NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                      NULL, /* allocator */
                                                                                      (CFStringRef)[params objectForKey:key],
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      kCFStringEncodingUTF8);
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        [escaped_value release];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    
    return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

- (NSString*)getHTTPMethodStringByHTTPMethod:(BOCOPPayHttpRequestMethod)method
{
    if ([self getHttpMethod] == BOCOPPayHttpRequestMethodPost) {
        return @"POST";
    }else if ([self getHttpMethod] == BOCOPPayHttpRequestMethodPut) {
        return @"PUT";
    }else if([self getHttpMethod] == BOCOPPayHttpRequestMethodDelete){
        return @"DELETE";
    }else{
        return @"GET";
    }
}
#pragma mark - Init Methods
+ (id)requestWithParams:(NSDictionary *)params
                headers:(NSDictionary*)headers
{
    BOCOPPayDataRequest *request = [[[[self class] alloc] init] autorelease];
    request.params = params;
    request.headers = headers;
    
    [[BOCOPPayRequestManager sharedManager] addRequest:request];
    return request;
}

+ (id)requestWithHeaders:(NSDictionary*)headers
{
    return [[self class] requestWithParams:nil headers:headers];
}

+ (id)requestWithParams:(NSDictionary *)params
{
    return [[self class] requestWithParams:params headers:nil];
}


#pragma mark - Public Methods


- (void)connect
{
    NSString* urlString = nil;
    if (_params && [_params count] > 0) {
        urlString = [self serializeURL:[self getURLString]
                                params:_params];
    }else{
        urlString = [self getURLString];
    }
    NSLog(@"url:%@",urlString);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:120];
  //  [request setTimeoutInterval:120];
    
    request.networkServiceType = NSURLNetworkServiceTypeVoIP;

    [request setHTTPMethod:[self getHTTPMethodStringByHTTPMethod:[self getHttpMethod]]];
    
    if ([self getHttpMethod] == BOCOPPayHttpRequestMethodPost || [self getHttpMethod] == BOCOPPayHttpRequestMethodPut) {
        [request setHTTPBody:[self getPostBody]];
        NSLog(@"post body:%@",_postJSON);
    }
    for (NSString *key in [_headers keyEnumerator]){
        NSString *value = _headers[key];
        [request setValue:[self encodeURL:value] forHTTPHeaderField:key];
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    NSLog(@"headers:%@",request.allHTTPHeaderFields);
    
	[_connection cancel];
    [_connection release];
    _connection = nil;
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)disconnect
{
    [_responseData release];
	_responseData = nil;
    
    [_connection cancel];
    [_connection release];
    _connection = nil;
    [self releaseSelf];
}

- (void)releaseSelf
{
    [[BOCOPPayRequestManager sharedManager] removeRequest:self];
}
#pragma mark - NSURLConnection Delegate Methods
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    BOCOPDINFO(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSDictionary* headers = [httpResponse allHeaderFields];
    BOCOPDINFO(@"ResponseHeaders: %@", headers);
    BOCOPDINFO(@"ResponseHeaders AlkKeys%@",[headers allKeys]);
    
    self.Cookie = [[headers objectForKey:@"Set-Cookie"] substringToIndex:[[headers objectForKey:@"Set-Cookie"] rangeOfString:@";"].location];
    NSLog(@"QQQQQQQ   ____%@",self.Cookie);
    
    [_responseData release];
    _responseData = nil;
	_responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	[self handleResponseData:_responseData];

	[_responseData release];
	_responseData = nil;
    
    [_connection cancel];
	[_connection release];
	_connection = nil;
    [self releaseSelf];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	[self failedWithError:error];
	[_responseData release];
	_responseData = nil;
    
    [_connection cancel];
	[_connection release];
	_connection = nil;
    
    [self releaseSelf];
}
#pragma mark - public methods

- (void)onRequestFailWithError:(void (^)(NSError *error))onRequestFailWithError
{
    [_onRequestFailWithError release];
    _onRequestFailWithError = nil;
    _onRequestFailWithError = [onRequestFailWithError copy];
}

- (void)onRequestDidFinishLoadingWithResult:(void (^)(NSDictionary *result))onRequestDidFinishLoadingWithResult
{
    [_onRequestDidFinishLoadingWithResult release];
    _onRequestDidFinishLoadingWithResult = nil;
    _onRequestDidFinishLoadingWithResult = [onRequestDidFinishLoadingWithResult copy];
}


#pragma mark - hook methods
- (NSString*)getURLString{
    //this should be implemented by subclass
    return nil;
}

- (BOCOPPayHttpRequestMethod)getHttpMethod
{
    return BOCOPPayHttpRequestMethodGet;
}
@end
