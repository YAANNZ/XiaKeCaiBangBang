//
//  UIBarButtonItem+Extension.h
//  openBridge
//
//  Created by doubin on 15/9/11.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
