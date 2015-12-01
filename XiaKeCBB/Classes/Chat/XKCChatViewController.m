//
//  XKCChatViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/9.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCChatViewController.h"
#import "XKCAccountTool.h"
#import "XKCChatDetailViewController.h"

@interface XKCChatViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic, strong) EMGroup *emGroup;

@end

@implementation XKCChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = XKCBaseColor;
    
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    dismissButton.x = self.view.width - 100.0;
//    dismissButton.y = 30.0;
    dismissButton.width = 80.0;
    dismissButton.height = 20.0;
    dismissButton.backgroundColor = [UIColor brownColor];
    dismissButton.layer.cornerRadius = 4.0;
    dismissButton.layer.masksToBounds = YES;
    dismissButton.layer.borderWidth = 0.5f;
    dismissButton.layer.borderColor = [[UIColor blackColor] CGColor];
    dismissButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:dismissButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:dismissButton];
    
    XKCAccount *account = [XKCAccountTool account];
    if ([account.uid isEqualToString:@"18701629187"] && ![[NSUserDefaults standardUserDefaults] objectForKey:@"isGroupExist"]) {
        // 创建群组
        EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
        groupStyleSetting.groupMaxUsersCount = 1111; // 创建500人的群，如果不设置，默认是200人。
        groupStyleSetting.groupStyle = eGroupStyle_PrivateOnlyOwnerInvite; // 只允许群主添加人进群
        [[EaseMob sharedInstance].chatManager asyncCreateGroupWithSubject:@"侠客菜帮帮" description:@"侠客菜帮帮帮会群" invitees:@[@"15001283127",@"15315900956",@"18588233871",@"18611102330"]initialWelcomeMessage:@"欢迎加入侠客菜帮帮" styleSetting:groupStyleSetting completion:^(EMGroup *group, EMError *error) {
            if(!error)
            {
                NSLog(@"创建成功 -- %@",group);
                [[NSUserDefaults standardUserDefaults] setObject:@"exist" forKey:@"isGroupExist"];
                [self getGroup]; // 刷新数据
            }
            else
            {
                XKCLog(@"%@",error);
            }
        } onQueue:nil];
    }
    else
    {
        [self getGroup]; // 刷新数据
    }
}

// 获取本账号相关的群组
- (void)getGroup
{
    [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsListWithCompletion:^(NSArray *groups, EMError *error) {
        if ((error == nil)&&(groups != nil)) {
            XKCLog(@"获取群组成功 -- %@",groups);
            self.emGroup = groups[0];
            [self.tableView reloadData];
        } else {
            XKCLog(@"获取群组失败");
        }
    } onQueue:nil];
}

#pragma mark - Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"chatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor brownColor];
    cell.imageView.image = [UIImage imageNamed:@"groupIcon.png"];
    cell.textLabel.text = self.emGroup.groupSubject;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.emGroup.groupOnlineOccupantsCount,self.emGroup.groupOccupantsCount];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XKCChatDetailViewController *detailVC = [[XKCChatDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - 点击事件处理
- (void)dismissButtonClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
