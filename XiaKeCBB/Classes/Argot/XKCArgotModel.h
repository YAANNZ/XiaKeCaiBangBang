//
//  XKCArgotModel.h
//  XiaKeCBB
//
//  Created by doubin on 15/12/2.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCArgotModel : NSObject

@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, assign) float queLableW;
@property (nonatomic, assign) float queLableH;
@property (nonatomic, assign) float answerLableW;
@property (nonatomic, assign) float answerLableH;

@end
