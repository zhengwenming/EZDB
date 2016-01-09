//
//  BOCPayObjectSingleton.h
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//
/// This macro implements the various methods needed to make a safe singleton.
/// Sample usage:
///
/// BOCOPOBJECT_SINGLETON_BOILERPLATE(SomeUsefulManager, sharedSomeUsefulManager)
/// (with no trailing semicolon)
///

#ifndef BOCOPPayObjectSingleton_h
#define BOCOPPayObjectSingleton_h 1

#define BOCOPOBJECT_SINGLETON_BOILERPLATE(_object_name_, _shared_obj_name_) \
static _object_name_ *z##_shared_obj_name_ = nil;  \
+ (_object_name_ *)_shared_obj_name_ {             \
@synchronized(self) {                            \
if (z##_shared_obj_name_ == nil) {             \
/* Note that 'self' may not be the same as _object_name_ */                               \
/* first assignment done in allocWithZone but we must reassign in case init fails */      \
z##_shared_obj_name_ = [[self alloc] init];                                               \
}                                              \
}                                                \
return z##_shared_obj_name_;                     \
}                                                  \
+ (id)allocWithZone:(NSZone *)zone {               \
@synchronized(self) {                            \
if (z##_shared_obj_name_ == nil) {             \
z##_shared_obj_name_ = [super allocWithZone:zone]; \
return z##_shared_obj_name_;                 \
}                                              \
}                                                \
\
/* We can't return the shared instance, because it's been init'd */     \
return nil;                                    \
}                                                  \
- (id)retain {                                     \
return self;                                   \
}                                                  \
- (NSUInteger)retainCount {                        \
return NSUIntegerMax;                          \
}                                                  \
- (oneway void)release {                                  \
}                                                  \
- (id)autorelease {                                \
return self;                                   \
}                                                  \
- (id)copyWithZone:(NSZone *)zone {                \
return self;                                   \
}                                                  \

#endif

