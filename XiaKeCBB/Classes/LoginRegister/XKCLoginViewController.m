//
//  XKCLoginViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/10/14.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCLoginViewController.h"
#import "XKCLoginBgView.h"
#import "XKCRegisterViewController.h"
#import "XKCAccountTool.h"
#import "XKCKeychain.h"
#import "Reachability.h"

@interface XKCLoginViewController () <XKCLoginBgViewDelegate>

//@property (nonatomic, weak) XKCLoginBgButton *backgroundBtn;
@property (nonatomic, assign) BOOL isClickedEyeButton;

@end

@implementation XKCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self setUpViewContent];
    [self checkReachabilityStatus]; // 监测一下网络状态
}

#pragma mark - 布局
- (void)setUpViewContent
{
    XKCLoginBgView *backgroundView = [[XKCLoginBgView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    backgroundView.delegate = self;
    [self.view addSubview:backgroundView];
}

#pragma mark - 监测网络状态
- (void)checkReachabilityStatus
{
    Reachability *reachabilityManager = [Reachability reachabilityWithHostName:@"baidu.com"];
    NSString *statusStr;
    switch (reachabilityManager.currentReachabilityStatus) {
        case NotReachable:
            statusStr = @"登不上的，都没联网";
            break;
        case ReachableViaWiFi:
            statusStr = @"WiFi已连";
            break;
        case ReachableViaWWAN:
            statusStr = @"任性你就别连WiFi";
            break;
        default:
            break;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = statusStr;
    [hud hide:YES afterDelay:1.5];
}

#pragma mark - XKCLoginBgButtonDelegate
// 背景按钮点击事件处理
- (void)loginBgViewWithBgBtnClicked:(UIButton *)bgBtn
{
    [self.view endEditing:YES];
}

// 眼睛按钮点击事件处理
- (void)loginBgViewWithEyeBtnClicked:(UIButton *)eyeBtn imageView:(UIImageView *)imageV passwordTextF:(UITextField *)passwordTextF
{
    if (self.isClickedEyeButton) {
        self.isClickedEyeButton = NO;
        imageV.image = [UIImage imageNamed:@"denglu_yanjing2"];
        passwordTextF.secureTextEntry = YES;
    }else{
        self.isClickedEyeButton = YES;
        imageV.image = [UIImage imageNamed:@"denglu_yanjing1"];
        passwordTextF.secureTextEntry = NO;
    }
}

// 登录按钮点击事件处理
- (void)loginBgViewWithloginBtnClicked:(UIButton *)loginBtn usernameTextF:(UITextField *)usernameTextF passwordTextF:(UITextField *)passwordTextF
{
    [self.view endEditing:YES];
    // 检测是否输入了电话号码
    if (usernameTextF.text.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入账号";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    
    // 检测是否输入了密码
    if (passwordTextF.text.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入密码";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    
    // 登录
    [self loginBmobWithUsername:usernameTextF.text password:passwordTextF.text];
}

- (void)loginBmobWithUsername:(NSString *)username password:(NSString *)password
{
    // 发请求验证帐号密码
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userinfo"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        BOOL success = NO;
        for (BmobObject *obj in array)
        {
            if ([[obj objectForKey:@"username"] isEqualToString:username] && [[obj objectForKey:@"password"] isEqualToString:password])
            {
                XKCLog(@"登陆成功");
                // 存储帐号
                XKCAccount *account = [XKCAccount accountWithDict:@{@"uid": username}];
                [XKCAccountTool save:account];
                [XKCKeychain savePassWord:password];
                success = YES;
                if ([self.delegate respondsToSelector:@selector(loginViewController:loginSuccessWithUsername:password:)])
                {
                    [self.delegate loginViewController:self loginSuccessWithUsername:username password:password];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            }
        }
        if (!success) {
            //提示帐号密码错误
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"帐号或密码错误";
            [hud hide:YES afterDelay:1.5];
        }
    }];
}

- (void)loginBgViewWithRegisterBtnClicked:(UIButton *)registerBtn
{
    XKCRegisterViewController *registerVC = [[XKCRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
