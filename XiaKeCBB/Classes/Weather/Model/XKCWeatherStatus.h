//
//  XKCWeatherStatus.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/3.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKCWeatherStatusResult.h"

@interface XKCWeatherStatus : NSObject

/** 请求状态码 */
@property(nonatomic, copy) NSString *resultcode;

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, strong) XKCWeatherStatusResult *result;

@end
