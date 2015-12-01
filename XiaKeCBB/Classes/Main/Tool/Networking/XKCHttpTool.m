//
//  XKCHttpTool.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/4.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCHttpTool.h"
#import "AFNetworking.h"

@implementation XKCHttpTool

+ (void)post:(NSString *)url headerValue:(NSString *)headerValue headerKey:(NSString *)headerKey params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建一个请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 2.判断是否需要添加请求头
    if (headerValue) {
        [mgr.requestSerializer setValue:headerValue forHTTPHeaderField:headerKey];
    }
    // 3.发送一个POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)get:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建一个请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送一个GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

@end
