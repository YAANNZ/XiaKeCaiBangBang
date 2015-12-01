//
//  XKCAccountTool.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/10/17.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKCAccount.h"

@interface XKCAccountTool : NSObject

/**
 *  存储帐号信息
 */
+ (void)save:(XKCAccount *)account;

/**
 *  获得存储的帐号
 *  @return 帐号过期, 返回nil
 */
+ (XKCAccount *)account;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
