//
//  BOCOPPayDataRequest.h
//  
//  Based on OAuth 2.0
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger{
	BOCOPPayHttpRequestMethodGet = 0,
	BOCOPPayHttpRequestMethodPost = 1,
	BOCOPPayHttpRequestMethodPut = 2,
    BOCOPPayHttpRequestMethodDelete = 3
} BOCOPPayHttpRequestMethod;

@interface BOCOPPayDataRequest : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic, retain) NSDictionary *headers;
@property (nonatomic, retain) NSString *postJSON;
@property (nonatomic, retain) NSString *Cookie;

+ (id)requestWithParams:(NSDictionary *)params
            headers:(NSDictionary*)headers;

+ (id)requestWithHeaders:(NSDictionary*)headers;

+ (id)requestWithParams:(NSDictionary *)params;

- (void)connect;
- (void)disconnect;

- (void)onRequestFailWithError:(void (^)(NSError *error))onRequestFailWithError;
- (void)onRequestDidFinishLoadingWithResult:(void (^)(NSDictionary *result))onRequestDidFinishLoadingWithResult;

#pragma mark - hook methods
- (NSString*)getURLString;
- (BOCOPPayHttpRequestMethod)getHttpMethod;
@end
