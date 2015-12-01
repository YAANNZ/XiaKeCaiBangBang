//
//  XKCGroupItem.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCGroupItem : NSObject

@property (nonatomic,copy) NSString *headerHeight;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic,copy) NSString *footerHeight;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *items;

+ (instancetype)groupWithItems:(NSMutableArray *) items;

@end
