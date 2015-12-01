//
//  UIImage+Extension.m
//  openBridge
//
//  Created by doubin on 15/9/1.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)circleImageWithBorderWidth:(CGFloat)inset borderColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    CGContextSetLineWidth(context,inset);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGRect rect = CGRectMake(inset, inset, self.size.width - inset *2.0f, self.size.height - inset *2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    //在圆区域内画出image原图
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    
    //生成新的image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)z_customImageWith:(UIColor *)color size:(CGSize)size shape:(ZCustomImageShape)shape
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    //    CGContextSetLineWidth(context,2);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGRect rect = {CGPointZero, size};
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    //在圆区域内画出image原图
    //    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    
    //生成image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
    
@end
