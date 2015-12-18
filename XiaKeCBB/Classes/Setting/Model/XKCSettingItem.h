//
//  XKCSettingItem.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XKCSettingItemOption)(NSIndexPath *indexPath);

@interface XKCSettingItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *cellHeight;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, strong) UIView *customView;
// 保存cell的功能
@property (nonatomic,copy) XKCSettingItemOption option;

@end
