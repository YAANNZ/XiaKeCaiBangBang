//
//  XKCKeychain.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/10/25.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCKeychain : NSObject

+(void)savePassWord:(NSString *)password;
+(id)readPassWord;
+(void)deletePassWord;

+ (void)save:(NSString *)service data:(id)data;
+ (void)delete:(NSString *)service;

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (id)load:(NSString *)service;

@end
