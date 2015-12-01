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
    if (account)
    {
//        if ([[NSDate date] compare:account.expires_time] != NSOrderedAscending)
//        {
//            return nil;
//        }
        return account;
    }
    
    return nil;
}

#pragma mark - 手机号码校验

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
             * 手机号码
             * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
             * 联通：130,131,132,152,155,156,185,186
             * 电信：133,1349,153,180,189
             */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
             10         * 中国移动：China Mobile
             11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
             12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
             15         * 中国联通：China Unicom
             16         * 130,131,132,152,155,156,185,186
             17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
             20         * 中国电信：China Telecom
             21         * 133,1349,153,180,189,181,183
             22         */
    NSString * CT = @"^1((33|53|8[0139])[0-9]|349)\\d{7}$";
    /**
     *       23         * 虚拟运营商
     *                  * 177
     */
    NSString * CV = @"^1((77|7[0569])[0-9])\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestcv = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CV];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestcv evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

@end
