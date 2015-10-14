//
//  UIImage+Extension.m
//  openBridge
//
//  Created by doubin on 15/9/1.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

#pragma mark 返回一张不需要渲染的图片
+ (instancetype)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
