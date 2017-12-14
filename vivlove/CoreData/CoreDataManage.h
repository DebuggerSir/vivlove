//
//  CoreDataManage.h
//  vivlove
//
//  Created by Skyer God on 2017/12/14.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManage : NSObject
/**
 单例化数据库对象
 */
+ (instancetype)shareCoreDataDB;

/**
 创建数据库，传入数据库名字
 */
- (instancetype)createCoredataDB:(NSString * )DBname;

/**
 插入数据
 */
+ (void)inserDataWith_CoredatamodelClass:(Class)modelclass CoredataModel:(void (^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError;

//+ (void)selectDataWith_CoredatamoldeClass:(Class)modelclass Alldata_arr:(void(^)(NSArray * coredataModelArr))CoredatamodelArr Error:(void (^)(NSError * error))resutError;

/**
 查询数据，查询条件nil为全部查询
 */
+ (void)selectDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr Alldata_arr:(void(^)(NSArray * coredataModelArr))CoredatamodelArr Error:(void (^)(NSError * error))resutError;

/**
 删除数据，删除条件为nil为全部删除
 */
+ (void)deleteDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(BOOL isResult))isresult Error:(void (^)(NSError * error))resutError;

/**
 更新数据
 */
+ (void)updataDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError;
@end
