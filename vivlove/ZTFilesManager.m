//
//  ZTFilesManager.m
//  vivlove
//
//  Created by Skyer God on 2017/12/14.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import "ZTFilesManager.h"

@implementation ZTFilesManager
+(NSString *)createDocumentPathWithDirctory:(NSString *)directory fileName:(NSString *)fileName{
    NSString *fileDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:directory];
    return [ZTFilesManager createFilePathWithDirctory:fileDir fileName:fileName];
}
+(NSString *)createLibraryPathWithDirctory:(NSString *)directory fileName:(NSString *)fileName{
    NSString *fileDir = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:directory];
    return [ZTFilesManager createFilePathWithDirctory:fileDir fileName:fileName];
}
+(NSString *)createCachesPathWithDirctory:(NSString *)directory fileName:(NSString *)fileName{
    NSString *fileDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:directory];
    return [ZTFilesManager createFilePathWithDirctory:fileDir fileName:fileName];
}
+(NSString *)createTempPathWithDirctory:(NSString *)directory fileName:(NSString *)fileName{
    NSString *fileDir = [NSTemporaryDirectory() stringByAppendingPathComponent:directory];
    return [ZTFilesManager createFilePathWithDirctory:fileDir fileName:fileName];
}
+ (NSString *)createFilePathWithDirctory:(NSString *)dirctory fileName:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [dirctory stringByAppendingPathComponent:fileName];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:dirctory isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtPath:dirctory withIntermediateDirectories:YES attributes:nil error:&error]) {
            //不存在路径，创建成功。
            return filePath;
        }
        [self alerShow:@"路径创建错误" info:dirctory];
    }
    if ([fileManager fileExistsAtPath:filePath]) {
        [self alerShow:@"文件已存在" info:fileName];
        return nil;
    } else {
        //存在路径，并且不包含此文件名
        return filePath;
    }
}
+ (void)alerShow:(NSString *)title info:(id )info{
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:title message:info delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertV show];
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
