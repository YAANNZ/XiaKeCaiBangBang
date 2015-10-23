//
//  XKCAccount.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/10/17.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCAccount : NSObject <NSCoding>

/** 登录成功后获取的access token */
@property (nonatomic, copy) NSString *access_token;
/** 当前用户账号 */
@property (nonatomic, copy) NSString *uid;
/** access_token的生命周期，单位是秒数 */
@property (nonatomic, copy) NSString *expires_in;
/** access_token的过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
