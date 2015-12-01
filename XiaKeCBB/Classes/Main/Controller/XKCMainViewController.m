//
//  XKCMainViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/10/10.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCMainViewController.h"
#import "XKCMainCellData.h"
#import "XKCLoginViewController.h"
#import "XKCAccountTool.h"
#import "XKCChatViewController.h"
#import "Reachability.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "XKCWeatherViewController.h"

@interface XKCMainViewController () <UITableViewDataSource, UITableViewDelegate, XKCLoginViewControllerDelegate, UIDynamicAnimatorDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *numberArray;
@property(nonatomic, strong) NSMutableArray *realNumberArray;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) Reachability *reachabilityManager;

@property(nonatomic,strong)UIDynamicAnimator *animator; // 物理引擎动画

@end

@implementation XKCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = XKCBaseColor;
    
    // 布局
//    UIButton * chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    chatButton.x = self.view.width - 70.0;
//    chatButton.y = 30.0;
//    chatButton.width = 50.0;
//    chatButton.height = 20.0;
//    chatButton.backgroundColor = [UIColor brownColor];
//    chatButton.layer.cornerRadius = 4.0;
//    chatButton.layer.masksToBounds = YES;
//    chatButton.layer.borderWidth = 0.5f;
//    chatButton.layer.borderColor = [[UIColor blackColor] CGColor];
//    chatButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    [chatButton setTitle:@"风云" forState:UIControlStateNormal];
//    [chatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [chatButton addTarget:self action:@selector(weatherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:chatButton];
//    
//    UIButton * menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    menuButton.x = 20.0;
//    menuButton.y = 30.0;
//    menuButton.width = 50.0;
//    menuButton.height = 20.0;
//    menuButton.backgroundColor = [UIColor brownColor];
//    menuButton.layer.cornerRadius = 4.0;
//    menuButton.layer.masksToBounds = YES;
//    menuButton.layer.borderWidth = 0.5f;
//    menuButton.layer.borderColor = [[UIColor blackColor] CGColor];
//    menuButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    [menuButton setTitle:@"点我" forState:UIControlStateNormal];
//    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:menuButton];
    
    
//    UILabel *lable = [[UILabel alloc] init];
//    lable.width = 200;
//    lable.height = 50;
//    lable.x = (MAINSCREEN_WIDTH - lable.width)/2;
//    lable.y = 50;
//    lable.font = [UIFont systemFontOfSize:28];
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.text = @"侠客菜帮帮";
//    [self.view addSubview:lable];
    
    int tableViewW = 250;
    int tableViewH = 250;
    int tableViewX = (MAINSCREEN_WIDTH - tableViewW)/2;
    int tableViewY = 120;
    // 此处需要做plus适配
    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.hidden = YES;
    [self.view addSubview:tableView];
    self.tableView.backgroundColor = XKCBaseColor;
    
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    getBtn.width = 100;
    getBtn.height = 30;
    getBtn.y = CGRectGetMaxY(tableView.frame) + 50;
    getBtn.x = (MAINSCREEN_WIDTH - getBtn.width*2 - 50)/2;
    getBtn.layer.cornerRadius = 15;
    [getBtn setTitle:@"联络帮会成员" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getBtn setBackgroundColor:[UIColor grayColor]];
    [getBtn addTarget:self action:@selector(getAddressBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getBtn];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    updateBtn.width = 100;
    updateBtn.height = 30;
    updateBtn.y = getBtn.y;
    updateBtn.x = CGRectGetMaxX(getBtn.frame)+50;
    updateBtn.layer.cornerRadius = 15;
    [updateBtn setTitle:@"更新帮会成员" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [updateBtn setBackgroundColor:[UIColor grayColor]];
    [updateBtn addTarget:self action:@selector(updateAddressBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
    
    // 监听网络状态改变
    // 在通知中心注册联网状态监测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkReachabilityStatus) name:kReachabilityChangedNotification object:nil];
    // 启动监听,dealloc里要停止监听注销通知
    [self.reachabilityManager startNotifier];
}

#pragma mark - 监听网络状态改变
- (void)checkReachabilityStatus
{
//    Reachability *reachabilityManager = [Reachability reachabilityWithHostName:@"baidu.com"];
    NSString *statusStr;
    switch (self.reachabilityManager.currentReachabilityStatus) {
        case NotReachable:
            statusStr = @"网络已断开";
            break;
        case ReachableViaWiFi:
//            statusStr = @"已连接WiFi";
            break;
        case ReachableViaWWAN:
//            statusStr = @"已连接网络";
            break;
        default:
            break;
    }
    if (statusStr.length) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = statusStr;
        [hud hide:YES afterDelay:0.5];
    }
}

#pragma mark - 判断是否登录
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![XKCAccountTool account])
    {
        XKCLoginViewController *loginVC = [[XKCLoginViewController alloc] init];
        loginVC.delegate = self;
        UINavigationController *loginNavVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNavVC animated:YES completion:nil];
    }
}

#pragma mark - XKCLoginViewControllerDelegate
- (void)loginViewController:(XKCLoginViewController *)loginViewController loginSuccessWithUsername:(NSString *)username password:(NSString *)password
{
/**
 环信相关版本二再实现
    // 自动登录环信
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username password:password completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            XKCLog(@"环信登陆成功");
            // 设置自动登录
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            
        } else {
            XKCLog(@"环信登陆失败");
            
        }
    } onQueue:nil];
 */
    // 根据帐号更新UI
    
    
}


#pragma mark - dataSource method and delegate method

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    XKCMainCellData *cellData = self.numberArray[indexPath.row];
    UIImage *userImage = [UIImage imageNamed:[NSString stringWithFormat:@"userIcon%ld.png",indexPath.row]];
    if (userImage)
    {
        cell.imageView.image = [userImage circleImageWithBorderWidth:3 borderColor:XKCBaseColor];
    }
    else
    {
        cell.imageView.image = [[UIImage imageNamed:@"profile.png"] circleImageWithBorderWidth:5 borderColor:XKCBaseColor];
    }
    cell.textLabel.text = cellData.name;
    cell.detailTextLabel.text = cellData.number;
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XKCMainCellData *cellData = self.realNumberArray[indexPath.row];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"侠客菜帮帮" message:[NSString stringWithFormat:@"确定联络%@？",cellData.name] preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"等会儿" style:UIAlertActionStyleCancel handler:nil]];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"很确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIApplication *app = [UIApplication sharedApplication];
        XKCLog(@"%@",cellData.number);
        [app openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",cellData.number]]];
    }];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 按钮点击事件
- (void)getAddressBook:(UIButton *)getBtn
{
//    LAContext *context = [LAContext new];
//    NSError *error;
//    context.localizedFallbackTitle = @"侠客菜帮帮";
//    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
//    {
//        NSLog(@"Touch ID is available.");
//        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
//                localizedReason:NSLocalizedString(@"解除封印吧，少侠！", nil)
//                          reply:^(BOOL success, NSError *error) {
//                              if (success)
//                              {
//                                  NSLog(@"Authenticated using Touch ID.");
//                              }
//                              else
//                              {
//                                  if (error.code == kLAErrorUserFallback)
//                                  {
//                                      NSLog(@"User tapped Enter Password");
//                                  } else if (error.code == kLAErrorUserCancel) {
//                                      NSLog(@"User tapped Cancel");
//                                  } else {
//                                      NSLog(@"Authenticated failed.");
//                                  }
//                              }
//                          }
//         ];
//    }
//    else
//    {
//        NSLog(@"Touch ID is not available: %@", error);
//    }
    
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"AddressBook"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.numberArray removeAllObjects];
        for (BmobObject *obj in array)
        {
            XKCMainCellData *data = [[XKCMainCellData alloc] init];
            data.name = [obj objectForKey:@"name"];
            data.number = [obj objectForKey:@"number"];
            [self.realNumberArray addObject:data];
            
            XKCMainCellData *cellData = [[XKCMainCellData alloc] init];
            cellData.name = [obj objectForKey:@"name"];
            cellData.number = [obj objectForKey:@"number"];
            cellData.number = [cellData.number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            [self.numberArray addObject:cellData];
        }
        
        [self.tableView reloadData];
//        self.tableView.hidden = NO;
    }];
    
    // 设置getBtn的角度
    getBtn.transform = CGAffineTransformMakeRotation([self getAngle]);
    // 1、重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    // 1.1、碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    // 1.2、让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
    // 2.添加物理仿真元素
    [gravity addItem:getBtn];
    [collision addItem:getBtn];
    //3.执行
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    
}

- (void)updateAddressBook:(UIButton *)updateBtn
{
    // 设置getBtn的角度
    updateBtn.transform = CGAffineTransformMakeRotation([self getAngle]);
    // 1、重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    // 1.1、碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    // 1.2、让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
    // 2.添加物理仿真元素
    [gravity addItem:updateBtn];
    [collision addItem:updateBtn];
    //3.执行
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

- (CGFloat)getAngle
{
    CGFloat angle;
    if ((arc4random_uniform(10))%2) {
        angle = (M_PI_2/arc4random_uniform(10));
    }
    else
    {
        angle = -(M_PI_2/arc4random_uniform(10));
    }
    return angle;
}

#pragma mark - UIDynamicAnimatorDelegate
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    UIButton *btn = (UIButton *)[((UICollisionBehavior *)[animator.behaviors lastObject]).items lastObject];
//    XKCLog(@"%@", btn);
    [UIView animateWithDuration:1.0 animations:^{
        btn.alpha = 0;
    } completion:^(BOOL finished) {
        btn.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.4 animations:^{
            btn.alpha = 1.0;
            if ([btn.titleLabel.text isEqualToString:@"联络帮会成员"])
            {
                btn.frame = CGRectMake((MAINSCREEN_WIDTH - 200 - 50)/2, CGRectGetMaxY(self.tableView.frame) + 50, 100, 30);
            }
            else
            {
                btn.frame = CGRectMake((MAINSCREEN_WIDTH - 200 - 50)/2 + 150, CGRectGetMaxY(self.tableView.frame) + 50, 100, 30);
            }
            
        } completion:^(BOOL finished) {
            if ([btn.titleLabel.text isEqualToString:@"联络帮会成员"])
            {
                self.tableView.hidden = NO;
            }
            else
            {
                //            if ([[XKCAccountTool account].uid isEqualToString:@"18701629187"])
                //            {
                //                // 弹框添加删除数据
                //            }
                //            else
                //            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"目前仅帮主有此权限";
                [hud hide:YES afterDelay:1.5];
                //            }
            }
        }];
    }];
}

/**
 环信相关第二版再实现
- (void)chatButtonClick:(UIButton *)btn
{
    XKCChatViewController *ChatVC = [[XKCChatViewController alloc] init];
    UINavigationController *navChatVC = [[UINavigationController alloc] initWithRootViewController:ChatVC];
    [self presentViewController:navChatVC animated:YES completion:nil];
}
 */


#pragma mark - dealloc
- (void)dealloc
{
    [self.reachabilityManager stopNotifier];
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//    [super dealloc]; // MRC时此句写最后，ARC不得显示这句。
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

- (NSMutableArray *)realNumberArray
{
    if (_realNumberArray == nil)
    {
        _realNumberArray = [NSMutableArray array];
    }
    return _realNumberArray;
}

- (Reachability *)reachabilityManager
{
    if (_reachabilityManager == nil)
    {
        _reachabilityManager = [Reachability reachabilityWithHostName:@"baidu.com"];
    }
    return _reachabilityManager;
}

- (UIDynamicAnimator *)animator
{
    if (_animator == nil)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        _animator.delegate = self;
    }
    return _animator;
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
