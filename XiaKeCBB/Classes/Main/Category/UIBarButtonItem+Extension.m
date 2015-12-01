//
//  UIBarButtonItem+Extension.m
//  openBridge
//
//  Created by doubin on 15/9/11.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageOriginalWithName:@"white_arrow"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
