//
//  XKCAccountTool.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/10/17.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#define XKCAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "XKCAccountTool.h"

@implementation XKCAccountTool

/**
 *  存储帐号信息
 */
+ (void)save:(XKCAccount *)account
{
    // 计算过期时间
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:[account.expires_in doubleValue]];
    // 存储时间
    [NSKeyedArchiver archiveRootObject:account toFile:XKCAccountPath];
}

/**
 *  获得存储的帐号
 *
 *  @return 帐号过期, 返回nil
 */
+ (XKCAccount *)account
{
    XKCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XKCAccountPath];
    /**
     NSOrderedAscending = -1L, 升序, 右边 > 左边
     NSOrderedSame,   相同大小
     NSOrderedDescending 降序, 右边 < 左边
     */
    if ([[NSDate date] compare:account.expires_time] != NSOrderedAscending) {
        return nil;
    }
    return account;
}

@end
