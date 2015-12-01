//
//  XKCHttpTool.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/4.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCHttpTool : NSObject

/**
 *  post请求
 *
 *  @param url          请求URL
 *  @param params       普通的请求参数
 *  @param headerValue  请求头的值
 *  @param headerKey    请求头的key
 *  @param success      请求成功后的回调
 *  @param failure      请求失败后的回调
 */
+ (void)post:(NSString *)url headerValue:(NSString *)headerValue headerKey:(NSString *)headerKey params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  get请求
 *
 *  @param url     请求URL
 *  @param params  普通的请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)get:(NSString *)url params:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
