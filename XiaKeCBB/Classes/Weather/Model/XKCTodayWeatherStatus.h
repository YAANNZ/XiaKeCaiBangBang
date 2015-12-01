//
//  XKCTodayWeatherStatus.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/4.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCTodayWeatherStatus : NSObject

@property (nonatomic,copy) NSString *temperature;
@property (nonatomic,copy) NSString *dressing_index;
@property (nonatomic,copy) NSString *dressing_advice;
@property (nonatomic,copy) NSString *uv_index;

@end
