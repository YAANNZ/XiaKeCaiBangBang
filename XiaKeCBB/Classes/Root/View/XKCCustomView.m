//
//  XKCCustomView.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/30.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCCustomView.h"

@implementation XKCCustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.text.length != 0)
    {
        [self.text drawInRect:self.bounds withAttributes:@{
                                                           NSFontAttributeName: [UIFont systemFontOfSize:50],NSForegroundColorAttributeName: [UIColor whiteColor]
                                                           }];
    }
}


- (void)setText:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
}

@end
