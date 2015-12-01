//
//  UILabel+Extension.m
//  openBridge
//
//  Created by doubin on 15/9/8.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (CGSize)boundingRectWithSize:(CGSize )contentMaxSize
{
    self.numberOfLines = 0;
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    return [self.text boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
}

@end
