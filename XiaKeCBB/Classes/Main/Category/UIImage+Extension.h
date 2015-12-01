//
//  UIImage+Extension.h
//  openBridge
//
//  Created by doubin on 15/9/1.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZCustomImageTetragonumShape = 1, // 正方形
    ZCustomImageEllipticalShape, // 椭圆
    ZCustomImageCircularShape // 圆
} ZCustomImageShape;

@interface UIImage (Extension)

// 返回一张不需要渲染的图片
+ (instancetype)imageOriginalWithName:(NSString *)imageName;

// 用一个image画出一个圆形image
- (UIImage *)circleImageWithBorderWidth:(CGFloat) inset borderColor:(UIColor *)color;

// 自己画一个image，可选形状
+ (UIImage *)z_customImageWith:(UIColor *)color size:(CGSize )size shape:(ZCustomImageShape )shape;

@end
