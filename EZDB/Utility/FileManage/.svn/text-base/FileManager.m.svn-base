//
//  FileManager.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-19.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "FileManager.h"


#include <sys/stat.h>
#include <dirent.h>
@implementation FileManager
+(NSString *)rootFilePath{
    NSString *fileRoot = [(NSArray*)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    return fileRoot;
}
+(NSString *)filePath:(NSString *)fileName{
    NSString *fileRoot = [(NSArray*)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *filePath = [fileRoot stringByAppendingPathComponent:fileName];
    return filePath;
}
+(void)deleteFileWithPath:(NSString *)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
+(void)deleteFileWithFileName:(NSString *)fileName{
    NSString *fileRoot = [(NSArray*)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *filePath = [fileRoot stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
+(NSData *)getFileFromPathWithFileName:(NSString *)fileName{
    
    NSString *fileRoot = [(NSArray*)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *filePath = [fileRoot stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
    
}
#pragma mark - 获取文件大小
+ (NSInteger) getFileSize:(NSString*) path{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue];
        else
            return -1;
    }
    else{
        return -1;
    }
}
+(BOOL)fileExistsAtPath:(NSString *)path{
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        return YES;
    }else{
        return NO;
    }
}
+(void)createFileAtPath:(NSString *)path{
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+(NSString *)documentFilePath//document目录
{
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    return [documentPath objectAtIndex:0];
}


+(NSString *)LibraryFilePath//Library目录
{
    NSString *libraryPath = [(NSArray*)NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"Library目录为:%@",libraryPath);
    return libraryPath;
}
+(NSString *)CachesFilePath//Cahes目录
{
    NSString *cachesPath = [(NSArray *)NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"Caches目录为:%@",cachesPath);
    return cachesPath;
}
+(NSString *)tempFilePath{
    return NSTemporaryDirectory();
}
// 完全使用unix c函数获取目录下文件大小
+ (long long) folderSizeAtPath:(NSString*) folderPath{
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}

+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}
+ (void)removeAllFileExceptPath:(NSString *)filePath//删除某个目录中得所有文件，但是不删除该目录
{
    if (filePath.length == 0) {
        return;
    }
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
    NSString *fileName;
    while (fileName = [dirEnum nextObject]) {
        NSError *error;
        NSString *fileName2 = [filePath stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:fileName2 error:&error];
    }
}
@end
