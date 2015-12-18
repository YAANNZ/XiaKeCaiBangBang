//
//  XKCSettingCell.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKCSettingItem.h"

@interface XKCSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@property (nonatomic, strong) XKCSettingItem *item;

@end
