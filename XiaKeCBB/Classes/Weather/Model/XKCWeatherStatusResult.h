//
//  XKCWeatherStatusResult.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/3.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKCWeatherStatusSk.h"
#import "XKCTodayWeatherStatus.h"

@interface XKCWeatherStatusResult : NSObject

@property (nonatomic, strong) XKCWeatherStatusSk *sk;

@property (nonatomic, strong) XKCTodayWeatherStatus *today;

@property (nonatomic, strong) NSDictionary *future;

@end
