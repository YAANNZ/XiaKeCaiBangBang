//
//  XKCKeychain.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/10/25.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCKeychain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
/* 保存 */
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
/* 删除 */
+ (void)delete:(NSString *)service;


/**
 *  @brief  存储密码
 *
 *  @param  password    密码内容
 */
+(void)savePassWord:(NSString *)password;

/**
 *  @brief  读取密码
 *
 *  @return 密码内容
 */
+(id)readPassWord;

/**
 *  @brief  删除密码数据
 */
+(void)deletePassWord;

@end
