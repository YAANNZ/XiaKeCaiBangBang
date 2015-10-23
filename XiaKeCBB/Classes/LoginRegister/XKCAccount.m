//
//  XKCAccount.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/10/17.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCAccount.h"

@implementation XKCAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    XKCAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    return account;
}

/**
 *  从文件中解析对象的时候调用 : 在这个方法中说明对象的哪些属性需要取出来
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用 : 在这个方法中说明对象的哪些属性需要存储
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
}

@end
