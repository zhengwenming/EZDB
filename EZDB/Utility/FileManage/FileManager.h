//
//  FileManager.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-19.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+(NSString *)rootFilePath;//沙盒根目录
+(NSString *)filePath:(NSString *)fileName;//返回文件目录
+(void)deleteFileWithPath:(NSString *)filePath;//删除某个目录下的文件
+(void)deleteFileWithFileName:(NSString *)fileName;//根据文件名删除文件
+(NSData *)getFileFromPathWithFileName:(NSString *)fileName;//根据文件名获取数据
+ (NSInteger)getFileSize:(NSString*) path;
+(BOOL)fileExistsAtPath:(NSString *)path;
+(NSString *)LibraryFilePath;//Library目录
+(NSString *)CachesFilePath;//Cahes目录
+(NSString *)tempFilePath;
+(NSString *)documentFilePath;//document目录
+(void)createFileAtPath:(NSString *)path;
//获取某个文件目录下文件大小（字节）
+ (long long) folderSizeAtPath:(NSString*) folderPath;
+ (long long) _folderSizeAtPath: (const char*)folderPath;

+ (void)removeAllFileExceptPath:(NSString *)filePath;//删除某个目录中得所有文件，但是不删除该目录
@end

