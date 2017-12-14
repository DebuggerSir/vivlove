//
//  ZTFilesManager.m
//  vivlove
//
//  Created by Skyer God on 2017/12/14.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import "ZTFilesManager.h"

@implementation ZTFilesManager
+(NSString *)createDocumentPathWithExtension:(NSString *)documentName{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) firstObject] stringByAppendingPathComponent:documentName];
    [ZTFilesManager jugeCreateSuccess:filePath];
    return filePath;
}
+(NSString *)createLibraryPathWithExtension:(NSString *)libraryName{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, NO) firstObject] stringByAppendingPathComponent:libraryName];
    [ZTFilesManager jugeCreateSuccess:filePath];
    return filePath;
}
+(NSString *)createCachesPathWithExtension:(NSString *)cachesName{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, NO) firstObject] stringByAppendingPathComponent:cachesName];
    [ZTFilesManager jugeCreateSuccess:filePath];
    return filePath;
}
+(NSString *)createTempPathWithExtension:(NSString *)tempName{
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:tempName];
    [ZTFilesManager jugeCreateSuccess:filePath];
    return filePath;
}
+ (BOOL )jugeCreateSuccess:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];;
    if (!(isDir == YES && existed == YES)) {
        //Document 目录下创建一个 documentName 目录
        NSError *error = nil;
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        return YES;
    }
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"创建路径错误" message:[NSString stringWithFormat:@"请检查此路径是否正确:%@", filePath] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertV show];
    return NO;
}
- (void)fileManager:(NSString *) filePath { // filePath: 文件/目录的路径
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
//    // 取得一个目录下得所有文件名
//    NSArray *files = [fileManager subpathsAtPath:filePath];
//
//    // 读取某个文件
//    NSData *data = [fileManager contentsAtPath:filePath];
//
//    // 删除文件/文件夹
//    [fileManager removeItemAtPath:filePath error:nil];
}
@end
