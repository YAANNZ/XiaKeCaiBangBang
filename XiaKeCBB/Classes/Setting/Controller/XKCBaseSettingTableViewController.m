//
//  XKCBaseSettingTableViewController.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/26.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCBaseSettingTableViewController.h"

@interface XKCBaseSettingTableViewController ()

@end

@implementation XKCBaseSettingTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - 懒加载
- (NSMutableArray *)groups
{
    if (_groups == nil)
    {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}

#pragma mark - 重写初始化方法
- (instancetype)init
{
    if (self = [super init])
    {
        self = [self initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _groups.count;
}

// 返回一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XKCGroupItem *group = _groups[section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKCGroupItem *group = _groups[indexPath.section];
    XKCSettingItem *item = group.items[indexPath.row];
    return item.cellHeight.doubleValue;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    XKCGroupItem *group = _groups[section];
    return group.headerHeight.doubleValue;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XKCGroupItem *group = _groups[section];
    return group.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    XKCGroupItem *group = _groups[section];
    return group.footerHeight.doubleValue;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XKCGroupItem *group = _groups[section];
    return group.footerView;
}

// 返回一行长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    XKCGroupItem *group = _groups[indexPath.section];
    XKCSettingItem *item = group.items[indexPath.row];
    
    XKCSettingCell *cell = [XKCSettingCell cellWithTableView:tableView style:item.cellStyle];
    
    // 设置模型
    cell.item = item;
    
    return cell;
}


#pragma mark - tableView代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取点击的模型
    XKCGroupItem *group = _groups[indexPath.section];
    XKCSettingItem *item = group.items[indexPath.row];
    
    if (item.option) { // 有操作
        item.option(indexPath);
        return;
    }
    
    //    if ([item isKindOfClass:[HMCSettingArrowItem class]]) {
    //        HMCSettingArrowItem *arrowItem = (HMCSettingArrowItem *)item;
    //
    //        if (arrowItem.descVc) {
    //            UIViewController *vc = [[arrowItem.descVc alloc] init];
    //            vc.title = item.title;
    //            [self.navigationController pushViewController:vc animated:YES];
    //
    //        }
    //    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
