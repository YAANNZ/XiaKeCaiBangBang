//
//  XKCSettingCell.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCSettingCell.h"

@implementation XKCSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    static NSString *ID = @"cell";
    XKCSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil || (cell.item.cellStyle != style))
    {
        cell = [[XKCSettingCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setItem:(XKCSettingItem *)item
{
    _item = item;
    
    // 设置数据
    [self setUpData];
    
}

- (void)setUpData
{
    if (_item.title) {
        self.textLabel.text = _item.title;
    }
    
    if (_item.subTitle) {
        self.detailTextLabel.text = _item.subTitle;
    }
    
    if (_item.image) {
        self.imageView.image = _item.image;
    }
    
    self.accessoryType = _item.accessoryType;
    //    HMCLog(@"%@",self.contentView.subviews);
    if (_item.customView) {
        [[self.contentView.subviews lastObject] removeFromSuperview];
        [self.contentView addSubview:_item.customView];
    }
}

@end
