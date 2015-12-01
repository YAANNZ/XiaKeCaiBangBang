//
//  XKCGroupItem.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCGroupItem.h"

@implementation XKCGroupItem

+ (instancetype)groupWithItems:(NSMutableArray *)items
{
    XKCGroupItem *group = [[XKCGroupItem alloc] init];
    
    group.items = items;
    
    return group;
}

@end
