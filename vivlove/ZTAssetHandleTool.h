//
//  ZTAssetHandleTool.h
//  vivlove
//
//  Created by Skyer God on 2017/12/13.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^Result)(NSData *fileData, NSString *fileName);
typedef void(^ResultPath)(NSData *fileData, NSString *fileName, NSString *filePath, PHAssetResource *pHAssetResource);

@interface ZTAssetHandleTool : NSObject
+ (void)getImageFromPHAsset:(PHAsset *)asset Complete:(Result)result;
+ (void)getVideoFromPHAsset:(PHAsset *)asset needMetaData:(BOOL)needMetaData Complete:(ResultPath)result;
@end
