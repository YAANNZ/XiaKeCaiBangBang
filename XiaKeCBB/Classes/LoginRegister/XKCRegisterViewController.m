//
//  XKCRegisterViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/10/14.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCRegisterViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "XKCAccountTool.h"

@interface XKCRegisterViewController ()

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

@property (nonatomic, weak) UILabel *verifLabel;
@property (nonatomic,weak) UITextField *verifTextField;
@property (nonatomic, weak) UIButton *verifButton;
@property (nonatomic, weak) UIView *verifLineView;

@property (nonatomic, weak) UILabel *inviteCLabel;
@property (nonatomic,weak) UITextField *inviteCTextField;
@property (nonatomic, weak) UIView *inviteCLineView;

@property (nonatomic, weak) UIButton *registerButton;
@property (nonatomic, weak) UIButton *loginButton;

@property (nonatomic,assign) int oneMinuteInteger;
@property (nonatomic, strong) NSTimer *oneMinuteTimer;

@end

@implementation XKCRegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = XKCBaseColor;
    self.navigationController.navigationBar.translucent = NO;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"white_arrow" target:self action:@selector(back)];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self setUpViewContent]; // 布局
    
//    [self addTimer];
}

- (void)addTimer
{
    
    self.oneMinuteInteger = 60;
    
    self.oneMinuteTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(oneMinuteTimerAction:) userInfo:nil repeats:YES];
}

- (void)oneMinuteTimerAction:(id)sender
{
    if (self.oneMinuteInteger>0) {
        //@"*秒重新获取验证码"
        NSString *titleStr = [NSString stringWithFormat:@"%lds",(long)self.oneMinuteInteger];
        [self.verifButton setTitle:titleStr forState:UIControlStateNormal];
        self.oneMinuteInteger--;
    }else{
        //@"点击重新获取验证码"
        [self.oneMinuteTimer invalidate];
        self.oneMinuteTimer = nil;
        [self.verifButton setTitle:@"获取" forState:UIControlStateNormal];
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpViewContent
{
    self.view.backgroundColor = XKCBaseColor;
    
    // 1、背景按钮
    UIButton *backgroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    self.backgroundBtn = backgroundBtn;
    backgroundBtn.backgroundColor = XKCBaseColor;
    [backgroundBtn addTarget:self action:@selector(backgroundButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundBtn];
    
    CGFloat labelX = 45.0;
    CGFloat labelY = 58.0;
    CGFloat labelHeight = 44.0;
    NSInteger fontNum = 16;
    CGFloat textFieldWidth = 175.0;
    
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
    self.usernameLineView = usernameLineView;
    usernameLineView.backgroundColor = [UIColor whiteColor];
    [usernameLineView bringSubviewToFront:self.view];
    [self.view addSubview:usernameLineView];
    
    // 5、密码输入框左侧文字
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX + 15, usernameLineView.y + usernameLineView.height, 40, labelHeight)];
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
//    passwordTextField.placeholder = @"请输入密码";
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
    
    // 9、验证码输入框左侧文字
    UILabel *verifLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX - 5, passwordLineView.y + passwordLineView.height, 60, labelHeight)];
    self.verifLabel = verifLabel;
    verifLabel.text = @"验证码";
    verifLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    verifLabel.textColor = [UIColor brownColor];
    verifLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:verifLabel];
    
    // 10、验证码输入框
    UITextField *verifTextField = [[UITextField alloc] initWithFrame:CGRectMake(labelX + passwordLabel.width+30, passwordLineView.y + passwordLineView.height, textFieldWidth - 30, labelHeight)];
    self.verifTextField = verifTextField;
    verifTextField.secureTextEntry = YES;
//    verifTextField.placeholder = @"请输入验证码";
    verifTextField.secureTextEntry = YES;
    verifTextField.textColor = [UIColor whiteColor];
    verifTextField.font = [UIFont boldSystemFontOfSize:fontNum];
    verifTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]}];
    [self.view addSubview:verifTextField];
    
    // 11、验证码输入框下部白线
    UIView *verifLineView = [[UIView alloc] initWithFrame:CGRectMake(passwordLineView.x, verifLabel.y + verifLabel.height, MAINSCREEN_WIDTH - 90, 0.5)];
    self.verifLineView = verifLineView;
    verifLineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:verifLineView];
    
    // 12、验证码输入框右侧获取验证码按钮
    UIButton *verifButton = [UIButton buttonWithType:UIButtonTypeCustom];
    verifButton.frame = CGRectMake(MAINSCREEN_WIDTH - 81, passwordLineView.y + passwordLineView.height + 5, 40, 32);
    self.verifButton = verifButton;
    [verifButton setTitle:@"获取" forState:UIControlStateNormal];
    [verifButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [verifButton addTarget:self action:@selector(verifButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verifButton];
    
    // 13、邀请码输入框左侧文字
    UILabel *inviteCLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX - 5, verifLineView.y + verifLineView.height, 60, labelHeight)];
    self.inviteCLabel = inviteCLabel;
    inviteCLabel.text = @"邀请码";
    inviteCLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    inviteCLabel.textColor = [UIColor brownColor];
    inviteCLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:inviteCLabel];
    
    // 14、帐号输入框
    UITextField *inviteCTextField = [[UITextField alloc] initWithFrame:CGRectMake(labelX + passwordLabel.width+30, verifLineView.y + verifLineView.height, textFieldWidth, labelHeight)];
    self.inviteCTextField = inviteCTextField;
    inviteCTextField.font = [UIFont boldSystemFontOfSize:fontNum];
    inviteCTextField.textColor = [UIColor whiteColor];
    inviteCTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]}];
    [self.view addSubview:inviteCTextField];
    
    // 15、帐号输入框下部白线
    UIView *inviteCLineView = [[UIView alloc] initWithFrame:CGRectMake(labelX, inviteCLabel.y + inviteCLabel.height, MAINSCREEN_WIDTH - 90, 0.5)];
    self.inviteCLineView = inviteCLineView;
    inviteCLineView.backgroundColor = [UIColor whiteColor];
    [inviteCLineView bringSubviewToFront:self.view];
    [self.view addSubview:inviteCLineView];
    
    // 16、注册按钮
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(passwordLineView.x, inviteCLineView.y + inviteCLineView.height + labelHeight, MAINSCREEN_WIDTH - 90, labelHeight)];
    self.registerButton = registerButton;
    registerButton.backgroundColor = [UIColor brownColor];
    registerButton.layer.cornerRadius = 4.0;
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.borderWidth = 0.5f;
    registerButton.layer.borderColor = [[UIColor blackColor] CGColor];
    [registerButton setTitleColor:XKCBaseColor forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontNum + 2];
    [registerButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    // 17、登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake((MAINSCREEN_WIDTH - 120)/2, registerButton.y + registerButton.height + labelHeight * 3 / 2, 120, 30)];
    self.loginButton = loginButton;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    [loginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
}

#pragma mark - 点击事件
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

- (void)loginBtnClick:(UIButton *)loginBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取验证码
// 获取验证码按钮点击事件处理
- (void)verifButtonClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    // 计时器未到一分钟
    if (self.oneMinuteInteger>0)
    {
        return;
    }
    
    // 判断是否输入了帐号
    if (self.usernameTextField.text.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入手机号";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    // 判断手机号是否合法
    if (![XKCAccountTool isMobileNumber:self.usernameTextField.text])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入正确格式手机号";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    // 判断是否输入了密码
    if (self.passwordTextField.text.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入密码";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    XKCLog(@"%@",self.usernameTextField.text);
    // 获取验证码
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.usernameTextField.text zone:@"86" result:^(SMS_SDKError *error) {
        NSString *hudText;
        if (!error)
        {
            XKCLog(@"获取验证码成功");
            hudText = @"验证码已发送";
            [self addTimer];
            NSString *titleStr = [NSString stringWithFormat:@"%lds",(long)self.oneMinuteInteger];
            [btn setTitle:titleStr forState:UIControlStateNormal];
        }
        else
        {
            XKCLog(@"%@",[error.userInfo objectForKey:@"getVerificationCode"]);
            hudText = @"获取验证码失败";
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = hudText;
        [hud hide:YES afterDelay:1.5];
    }];
}



#pragma mark - 注册按钮事件点击处理
- (void)registerBtnClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    if (self.usernameTextField.text.length == 0)
    {
        //提示输入帐号
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入手机号";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    if (self.passwordTextField.text.length == 0)
    {
        //提示输入密码
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入密码";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    if (self.verifTextField.text.length == 0)
    {
        //提示输入验证码
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入验证码";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    if (self.inviteCTextField.text.length == 0)
    {
        //提示输入邀请码
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入邀请码";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    
    // 判断手机号是否已注册
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userinfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array)
        {
            if ([[obj objectForKey:@"username"] isEqualToString:self.usernameTextField.text])
            {
                //提示手机号已注册
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"手机号已注册";
                [hud hide:YES afterDelay:1.5];
                return;
            }
        }
    }];
    
    // 判断邀请码是否已使用
    BmobQuery *codeBquery = [BmobQuery queryWithClassName:@"InvitationCode"];
    [codeBquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array)
        {
            if ([[obj objectForKey:@"InvitationCode"] isEqualToString:self.inviteCTextField.text])
            {
                // 邀请码可用
                [obj setObject:self.usernameTextField.text forKey:@"user"];
                NSString *inviteCode = [NSString stringWithFormat:@"%@%d",self.inviteCTextField.text,arc4random_uniform(1000)];
                [obj setObject:inviteCode forKey:@"InvitationCode"];
                [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful)
                    {
                        [self verifyAndRegister];
                    }
                    else
                    {
                        // 提示邀请码使用出错
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"邀请码使用出错";
                        [hud hide:YES afterDelay:1.5];
                    }
                }];
                return;
            }
        }
        // 提示邀请码已失效
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"邀请码已失效";
        [hud hide:YES afterDelay:1.5];
    }];
}

- (void)verifyAndRegister
{
    // 验证验证码并注册登录
    [SMS_SDK commitVerifyCode:self.verifTextField.text result:^(enum SMS_ResponseState state) {
        NSLog(@"%d",state);
        if (state == 1)
        {
            XKCLog(@"验证成功");
            // 将注册信息存入Bmob后台
            BmobObject *userinfo = [BmobObject objectWithClassName:@"userinfo"];
            [userinfo setObject:self.usernameTextField.text forKey:@"username"];
            [userinfo setObject:self.passwordTextField.text forKey:@"password"];
            [userinfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                //进行操作
                if (isSuccessful)
                {
                    // 用户注册成功之后注册环信
                    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.usernameTextField.text password:self.passwordTextField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
                        if (!error) {
                            XKCLog(@"环信注册成功");
                            //提示注册成功
                            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"恭喜你注册成功";
                            [hud hide:YES afterDelay:1.5];
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                        else
                        {
                            XKCLog(@"环信注册失败");
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                    } onQueue:nil];
                }
                else
                {
                    XKCLog(@"%@",error);
                    //提示注册失败
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"注册失败";
                    [hud hide:YES afterDelay:1.5];
                }
            }];
        }
        else
        {
            XKCLog(@"验证失败");
            //提示输入验证码
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"验证失败";
            [hud hide:YES afterDelay:1.5];
            return;
        }
    }];
}








- (void)didReceiveMemoryWarning
{
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
