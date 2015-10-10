//
//  XKCMainViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/10/10.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

//设备屏幕大小
#define MAINSCREEN_FRAME   [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define MAINSCREEN_WIDTH  MAINSCREEN_FRAME.size.width
//设备屏幕高
#define MAINSCREEN_HEIGHT MAINSCREEN_FRAME.size.height

#import "XKCMainViewController.h"
#import "UIView+Extension.h"
#import <BmobSDK/Bmob.h>
#import "XKCMainCellData.h"

@interface XKCMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *numberArray;

@end

@implementation XKCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.width = 200;
    lable.height = 50;
    lable.x = (MAINSCREEN_WIDTH - lable.width)/2;
    lable.y = 100;
    lable.font = [UIFont systemFontOfSize:28];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"侠客菜帮帮";
    [self.view addSubview:lable];
    
//    [self addMobileNumber];
//    [self getAddressBook];
    
    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(lable.x,CGRectGetMaxY(lable.frame) + 20,200,120)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.hidden = YES;
    [self.view addSubview:tableView];
    self.tableView.backgroundColor = [UIColor brownColor];
    
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    getBtn.width = 100;
    getBtn.height = 30;
    getBtn.y = CGRectGetMaxY(tableView.frame) + 50;
    getBtn.x = (MAINSCREEN_WIDTH - getBtn.width)/2;
    getBtn.layer.cornerRadius = 15;
    [getBtn setTitle:@"联络帮会成员" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getBtn setBackgroundColor:[UIColor grayColor]];
    [getBtn addTarget:self action:@selector(getAddressBook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getBtn];
}

#pragma mark dataSource method and delegate method

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return self.numberArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *cellID = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor brownColor];
    XKCMainCellData *cellData = self.numberArray[indexPath.row];
    cell.textLabel.text = cellData.name;
    cell.detailTextLabel.text = cellData.number;
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)numberArray
{
    if (_numberArray == nil)
    {
        _numberArray = [NSMutableArray array];
    }
    return _numberArray;
}

//- (void)addMobileNumber
//{
//    BmobObject *addressBook = [BmobObject objectWithClassName:@"AddressBook"];
//    [addressBook setObject:@"朱亚男" forKey:@"name"];
//    [addressBook setObject:@"18701629187" forKey:@"number"];
//    [addressBook saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        //进行操作
//        if (isSuccessful) {
//            NSLog(@"成功");
//        }
//    }];
//}

- (void)getAddressBook
{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"AddressBook"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array)
        {
//            //打印playerName
//            NSLog(@"obj.name = %@", [obj objectForKey:@"name"]);
//            NSLog(@"obj.number = %@", [obj objectForKey:@"number"]);
//            //打印objectId,createdAt,updatedAt
//            NSLog(@"obj.objectId = %@", [obj objectId]);
//            NSLog(@"obj.createdAt = %@", [obj createdAt]);
//            NSLog(@"obj.updatedAt = %@", [obj updatedAt]);
            
            XKCMainCellData *cellData = [[XKCMainCellData alloc] init];
            cellData.name = [obj objectForKey:@"name"];
            cellData.number = [obj objectForKey:@"number"];
            [self.numberArray addObject:cellData];
        }
        
        [self.tableView reloadData];
        self.tableView.hidden = NO;
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
