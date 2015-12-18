//
//  XKCBaseSettingTableViewController.h
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKCSettingItem.h"
#import "XKCGroupItem.h"
#import "XKCSettingCell.h"


@interface XKCBaseSettingTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *groups;

@end
