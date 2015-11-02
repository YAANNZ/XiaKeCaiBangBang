//
//  XKCLoginViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/10/14.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCLoginViewController.h"
#import "XKCRegisterViewController.h"
#import "AFNetworking.h"
#import "XKCAccountTool.h"
#import "XKCKeychain.h"

@interface XKCLoginViewController ()

@property (nonatomic, weak) UIButton *backgroundBtn;
@property (nonatomic,weak) UITextField *usernameTextField;
@property (nonatomic,weak) UITextField *passwordTextField;
@property (nonatomic, weak) UILabel *usernameLabel;
@property (nonatomic, weak) UILabel *passwordLabel;
@property (nonatomic, weak) UIView *usernameLineView;
@property (nonatomic, weak) UIView *passwordLineView;
@property (nonatomic, weak) UIImageView *eyeImageView;
@property (nonatomic, weak) UIButton *eyeButton;
@property (nonatomic, assign) BOOL isClickedEyeButton;
@property (nonatomic, weak) UIButton *loginButton;
@property (nonatomic, weak) UIButton *registerButton;

@end

@implementation XKCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self setUpViewContent]; // 布局
    
}

#pragma mark - 布局
- (void)setUpViewContent
{
    // 1、背景按钮
    UIButton *backgroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    self.backgroundBtn = backgroundBtn;
    backgroundBtn.backgroundColor = XKCBaseColor;
    [backgroundBtn addTarget:self action:@selector(backgroundButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundBtn];
    
    CGFloat labelX = 45.0;
    CGFloat labelY = 102.0;
    CGFloat labelHeight = 44.0;
    NSInteger fontNum = 16;
    //    if (iPhone6Plus) {
    //        labelHeight = 50.0;
    //        fontNum = 18;
    //    }
    CGFloat textFieldWidth = 175.0;
    //    //适配6+
    //    if (iPhone6Plus) {
    //        textFieldWidth = 240;
    //    }
    
    // 2、帐号输入框左侧文字
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX+15, labelY, 40, labelHeight)];
    self.usernameLabel = usernameLabel;
    usernameLabel.text = @"+86";
    usernameLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    usernameLabel.textColor = [UIColor brownColor];
    usernameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:usernameLabel];
    
    // 3、帐号输入框
    UITextField *usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(labelX + usernameLabel.width + 30, labelY, textFieldWidth, labelHeight)];
    self.usernameTextField = usernameTextField;
    usernameTextField.font = [UIFont boldSystemFontOfSize:fontNum];
    usernameTextField.textColor = [UIColor whiteColor];
    usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]}];
    //    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
//    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:HMCUsername];
//    if (username.length>0) {
//        usernameTextField.text = username;
//    }
    [self.view addSubview:usernameTextField];
    
    // 4、帐号输入框下部白线
    UIView *usernameLineView = [[UIView alloc] initWithFrame:CGRectMake(labelX, usernameLabel.y + usernameLabel.height, MAINSCREEN_WIDTH - 90, 0.5)];
    usernameLineView.backgroundColor = [UIColor whiteColor];
    [usernameLineView bringSubviewToFront:self.view];
    [self.view addSubview:usernameLineView];
    
    // 5、密码输入框左侧文字
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX + 15, usernameLineView.y + usernameLineView.height + usernameLineView.frame.size.height, 40, labelHeight)];
    self.passwordLabel = passwordLabel;
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    passwordLabel.textColor = [UIColor brownColor];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:passwordLabel];
    
    // 6、密码输入框
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(labelX + passwordLabel.width+30, usernameLineView.y + usernameLineView.height, textFieldWidth - 30, labelHeight)];
    self.passwordTextField = passwordTextField;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.font = [UIFont boldSystemFontOfSize:fontNum];
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]}];
    //    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:HMCPassword];
    //    if (password.length>0) {
    //        passwordTextField.text = password;
    //    }
    [self.view addSubview:passwordTextField];
    
    // 7、密码输入框下部白线
    UIView *passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(usernameLineView.x, passwordLabel.y + passwordLabel.height, MAINSCREEN_WIDTH - 90, 0.5)];
    self.passwordLineView = passwordLineView;
    passwordLineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordLineView];
    
    // 8、密码输入框右侧眼睛图标
    UIImageView *eyeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH - 71, usernameLineView.y + usernameLineView.height + (labelHeight-12)/2, 21, 12)];
    self.eyeImageView = eyeImageView;
    eyeImageView.image = [UIImage imageNamed:@"denglu_yanjing2"];
    [self.view addSubview:eyeImageView];
    
    UIButton *eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH-81, usernameLineView.y + usernameLineView.height + 5, 40, 32)];
    self.eyeButton = eyeButton;
    [eyeButton addTarget:self action:@selector(eyeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeButton];
    
    // 9、登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(passwordLineView.x, passwordLineView.y + passwordLineView.height + labelHeight, MAINSCREEN_WIDTH - 90, labelHeight)];
    self.loginButton = loginButton;
    loginButton.backgroundColor = [UIColor brownColor];
    loginButton.layer.cornerRadius = 4.0;
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.borderWidth = 0.5f;
    loginButton.layer.borderColor = [[UIColor blackColor] CGColor];
    [loginButton setTitleColor:XKCBaseColor forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontNum + 2];
    [loginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    // 10、注册按钮
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((MAINSCREEN_WIDTH - 120)/2, loginButton.y + loginButton.height + labelHeight * 3 / 2, 120, 30)];
    self.registerButton = registerButton;
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    [registerButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}

#pragma mark - 按钮点击事件处理
// 背景按钮点击事件处理
- (void)backgroundButtonClick:(UIButton *)btn
{
    [self.view endEditing:YES];
}

// 眼睛按钮点击事件处理
- (void)eyeButtonClick:(UIButton *)btn
{
    if (self.isClickedEyeButton) {
        self.isClickedEyeButton = NO;
        self.eyeImageView.image = [UIImage imageNamed:@"denglu_yanjing2"];
        self.passwordTextField.secureTextEntry = YES;
    }else{
        self.isClickedEyeButton = YES;
        self.eyeImageView.image = [UIImage imageNamed:@"denglu_yanjing1"];
        self.passwordTextField.secureTextEntry = NO;
    }
}

// 登录按钮点击事件处理
- (void)loginBtnClick:(UIButton *)loginButton
{
    // 检测是否输入了电话号码
    
    // 登录
    [self login];
    
    // 友盟点击统计
    
    // 密码存入钥匙串
    [XKCKeychain savePassWord:self.passwordTextField.text];
    XKCLog(@"%@",[XKCKeychain readPassWord]);
    
    [self.view endEditing:YES];
//    [[NSUserDefaults standardUserDefaults] setObject:self.usernameTextField.text forKey:HMCUsername];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login
{
    // 1.创建一个请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"x_username"] = @"嘿嘿嘿";
//    params[@"x_password"] = @"128763123";
    
    // 3.发送一个POST请求
//    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
//      success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
////          [responseObject writeToFile:<#(nonnull NSString *)#> atomically:<#(BOOL)#>];
//          // 字典转为模型
//          XKCAccount *account = [XKCAccount accountWithDict:responseObject];
//          
//          // 存储帐号信息
//          [XKCAccountTool save:account];
//          
//          // 切换到主控制器
////          [UIApplication sharedApplication].keyWindow.rootViewController = [[HWTabBarController alloc] init];
//      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//          NSLog(@"请求失败 - %@", error);
//      }];

    
    params[@"cityname"] = @"北京";
    params[@"key"] = @"080bb98453dda71d25f7269a6a5f5371";
    [mgr GET:@"http://v.juhe.cn/weather/index" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        XKCLog(@"成功");
        XKCLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        XKCLog(@"失败");
    }];
    
    // 存入数据库！
}

- (void)registerBtnClick:(UIButton *)registerButton
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
