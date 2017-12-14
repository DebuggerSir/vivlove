//
//  ZTFilesManager.h
//  vivlove
//
//  Created by Skyer God on 2017/12/14.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTFilesManager : NSObject
+(NSString *)createDocumentPathWithExtension:(NSString *)documentName;
+(NSString *)createLibraryPathWithExtension:(NSString *)libraryName;
+(NSString *)createCachesPathWithExtension:(NSString *)cachesName;
+(NSString *)createTempPathWithExtension:(NSString *)tempName;


@end
