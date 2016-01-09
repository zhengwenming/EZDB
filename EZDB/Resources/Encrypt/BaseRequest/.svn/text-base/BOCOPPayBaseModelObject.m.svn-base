//
//  ITTBaseModelObject.m
//
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BOCOPPayBaseModelObject.h"

@implementation BOCOPPayBaseModelObject

-(id)initWithDataDic:(NSDictionary*)data
{
	if (self = [super init]) {
		[self setAttributes:data];
	}
	return self;
}

-(NSDictionary*)attributeMapDictionary{
	return nil;
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName
{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}

- (NSString *)customDescription
{
	return nil;
}

- (NSString *)description
{
	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			if (valueObj) {
				[attrsDesc appendFormat:@" [%@=%@] ",attributeName,valueObj];		
				//[valueObj release];			
			}else {
				[attrsDesc appendFormat:@" [%@=nil] ",attributeName];		
			}
			
		}
	}
	
	NSString *customDesc = [self customDescription];
	NSString *desc;
	
	if (customDesc && [customDesc length] > 0 ) {
		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
	}else {		
		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
	}
	
	return desc;
}
- (void)ConvertToDecimal
{
    //由需要实现的类实现
}
-(void)setAttributes:(NSDictionary*)dataDic
{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL sel = [self getSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
			NSString *dataDicKey = attrMapDic[attributeName];
			[self performSelectorOnMainThread:sel 
														 withObject:dataDic[dataDicKey] 
													waitUntilDone:[NSThread isMainThread]];		
		}
	}
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if( self = [super init] ){
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil) {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject])) {
			SEL sel = [self getSetterSelWithAttibuteName:attributeName];
			if ([self respondsToSelector:sel]) {
				id obj = [decoder decodeObjectForKey:attributeName];
				[self performSelectorOnMainThread:sel 
															 withObject:obj
														waitUntilDone:[NSThread isMainThread]];
			}
		}
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
    
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
    while ((attributeName = [keyEnum nextObject])) {
	
        SEL getSel = NSSelectorFromString(attributeName);
		
        if ([self respondsToSelector:getSel]) {
		
            NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			
			if (valueObj) {
				[encoder encodeObject:valueObj forKey:attributeName];	
			}
		}
	}
}

- (NSData*)getArchivedData
{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (void)SaveToLocal
{
    NSData *data = [self getArchivedData];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDocumnet = [paths objectAtIndex:0];
    
    NSString *fileName = [cachesDocumnet stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",[NSString stringWithUTF8String:object_getClassName(self)]]];
    NSLog(@"%@",fileName);
    [data writeToFile:fileName atomically:YES];
}

+ (BOCOPPayBaseModelObject *)GetLocalSelf
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDocumnet = [paths objectAtIndex:0];
    
    NSString *fileName = [cachesDocumnet stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",[NSString stringWithUTF8String:object_getClassName(self)]]];
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData: data];
}


@end
