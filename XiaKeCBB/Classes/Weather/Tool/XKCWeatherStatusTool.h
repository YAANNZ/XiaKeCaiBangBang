//
//  XKCWeatherStatusTool.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/1.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

/*
 但凡发现很多业务都与某个东西有关, 就可以封装一个业务类, 专门用于处理和该东西相关的业务
 提供一个方法, 让外界传入处理业务必须的参数
 提供一个成功的回调和一个失败的回调
 创建一个请求模型和一个结果模型(面向对象)
 */

#import <Foundation/Foundation.h>
#import "XKCWeatherStatusRequest.h"
#import "XKCWeatherStatus.h"

typedef void (^successBlock)(XKCWeatherStatus *statusResult);
typedef void (^failureBlock)(NSError *error);

@interface XKCWeatherStatusTool : NSObject

+ (void)statusWithParams:(XKCWeatherStatusRequest *)request success:(successBlock)success failure:(failureBlock)failure;

@end
