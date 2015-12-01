//
//  XKCWeatherStatusRequest.h
//  XiaKeCBB
//
//  Created by doubin on 15/11/6.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCWeatherStatusRequest : NSObject

@property (nonatomic, copy) NSString *cityname;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *access_token;

@end
