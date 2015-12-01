//
//  XKCWeatherStatusTool.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/1.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCWeatherStatusTool.h"
#import "FMDB.h"
#import "XKCAccountTool.h"

@implementation XKCWeatherStatusTool

static FMDatabase *_db;
+ (void)initialize
{
    // 获取数据的文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqliteFilePath = [path stringByAppendingPathComponent:@"status.sqlite"];
    
    // 打开数据库(有则打开，没有则创建后再打开)
    _db = [FMDatabase databaseWithPath:sqliteFilePath];
    
    // 创建表
    if ([_db open]) {
        NSLog(@"打开数据库成功");
        // 在企业级开发中, 写sql语句最好先用图形工具编写测试之后拷贝到项目中
//        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_status  (id INTEGER PRIMARY KEY AUTOINCREMENT, dict BLOB NOT NULL, access_token TEXT NOT NULL);";
        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_status  (id INTEGER PRIMARY KEY AUTOINCREMENT, dict BLOB NOT NULL);";
        ;
        if([_db executeUpdate:sql])
        {
            NSLog(@"创建表成功");
        }
    }
}

+ (BOOL)saveCacheStatus:(NSDictionary *)dict
{
    // 将字典转换为二进制
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted  error:NULL];
    // 获取access_token
//    NSString *access_token = [XKCAccountTool account].access_token;
    
    // 存储数据
//    BOOL success  = [_db executeUpdate:@"INSERT INTO t_status (dict, access_token) VALUES (?, ?);", data , access_token];
    BOOL success  = [_db executeUpdate:@"INSERT INTO t_status (dict) VALUES (?);", data];
    if (success) {
        NSLog(@"保存数据成功");
    }
    return YES;
}

+ (NSMutableDictionary *)cacheStatusWithRequest:(XKCWeatherStatusRequest *)request
{
    NSMutableDictionary *statuses = [NSMutableDictionary dictionary];
    FMResultSet *set = nil;

//    set = [_db executeQuery:@"SELECT * FROM t_status WHERE access_token = ?",  request.access_token];
    
    set = [_db executeQuery:@"SELECT * FROM t_status"];
    
    // 2.取出查询到的所有结果, 转换为对象存储到数组中返回
    while ([set next]) {
        // idstr, dict, access_token
        // 取出微博的idstr
        //        NSString *idstr = [set stringForColumn:@"idstr"];
        // 取出access_token
        //        NSString *access_token = [set stringForColumn:@"access_token"];
        // 取出微博二进制
        NSData *data = [set dataForColumn:@"dict"];
        // 先将二进制转换为字典
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        [statuses setDictionary:dict];
    }
    
    return statuses;

}

+ (void)statusWithParams:(XKCWeatherStatusRequest *)request success:(successBlock)success failure:(failureBlock)failure
{
    // 1.判断本地有没有数据
    // 从本地取出数据
    NSDictionary *statuses = [self cacheStatusWithRequest:request];
    if (statuses.count > 0) {
        // 从本地加载
        if (success) {
            // 将字典转换为模型
            XKCWeatherStatus *statusResult = [XKCWeatherStatus objectWithKeyValues:statuses];
            success(statusResult);
        }
    }else
    {
        // 从网络加载
        // 2.发送一个GET请求
        [XKCHttpTool get:@"http://v.juhe.cn/weather/index" params:request.keyValues
                success:^(id responseObject) {
                    
                    // 存储数据到本地
                    [self saveCacheStatus:responseObject];
                    
                    // 字典转模型
                    XKCWeatherStatus *statusResult = [XKCWeatherStatus objectWithKeyValues:responseObject];
                    
                    if (success) {
                        success(statusResult);
                    }
                    
                } failure:^(NSError *error) {
                    if (failure) {
                        failure(error);
                    }
                }];
    }
}

@end
