//
//  ZTFilesManager.h
//  vivlove
//
//  Created by Skyer God on 2017/12/14.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTFilesManager : NSObject
+(NSString *)createDocumentPathWithDirctory:(NSString *)dirctory fileName:(NSString *)fileName;
+(NSString *)createLibraryPathWithDirctory:(NSString *)dirctory fileName:(NSString *)fileName;
+(NSString *)createCachesPathWithDirctory:(NSString *)dirctory fileName:(NSString *)fileName;
+(NSString *)createTempPathWithDirctory:(NSString *)dirctory fileName:(NSString *)fileName;
+ (void)alerShow:(NSString *)title info:(id )info;

@end
