//
//  XKCLoginBgView.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/29.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCLoginBgView.h"

@interface XKCLoginBgView ()

@property (nonatomic, weak) UIButton *bgBtn;
@property (nonatomic,weak) UITextField *usernameTextField;
@property (nonatomic,weak) UITextField *passwordTextField;
@property (nonatomic, weak) UILabel *usernameLabel;
@property (nonatomic, weak) UILabel *passwordLabel;
@property (nonatomic, weak) UIView *usernameLineView;
@property (nonatomic, weak) UIView *passwordLineView;
@property (nonatomic, weak) UIImageView *eyeImageView;
@property (nonatomic, weak) UIButton *eyeButton;
@property (nonatomic, weak) UIButton *loginButton;
@property (nonatomic, weak) UIButton *registerButton;

@end

@implementation XKCLoginBgView

// 通过代码创建时调用此方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviews];
    }
    return self;
}

// 通过xib\storyboard创建才会调用此方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self addSubviews];
    }
    return self;
}

#pragma mark 初始化子控件
- (void)addSubviews
{
    // 1、背景按钮
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bgBtn = bgBtn;
    bgBtn.backgroundColor = XKCBaseColor;
    [bgBtn addTarget:self action:@selector(backgroundButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    
    // 2、帐号输入框左侧文字
    NSInteger fontNum = 16;
    //    if (iPhone6Plus) {
    //        labelHeight = 50.0;
    //        fontNum = 18;
    //    }
    UILabel *usernameLabel = [[UILabel alloc] init];
    self.usernameLabel = usernameLabel;
    usernameLabel.text = @"+86";
    usernameLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    usernameLabel.textColor = [UIColor brownColor];
    usernameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:usernameLabel];
    
    // 3、帐号输入框
    UITextField *usernameTextField = [[UITextField alloc] init];
    self.usernameTextField = usernameTextField;
    usernameTextField.font = [UIFont boldSystemFontOfSize:fontNum];
    usernameTextField.textColor = [UIColor whiteColor];
    usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]}];
    [self addSubview:usernameTextField];
    
    // 4、帐号输入框下部白线
    UIView *usernameLineView = [[UIView alloc] init];
    self.usernameLineView = usernameLineView;
    usernameLineView.backgroundColor = [UIColor whiteColor];
    //    [usernameLineView bringSubviewToFront:self]; // 想不起来这句干啥用的了
    [self addSubview:usernameLineView];
    
    // 5、密码输入框左侧文字
    UILabel *passwordLabel = [[UILabel alloc] init];
    self.passwordLabel = passwordLabel;
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    passwordLabel.textColor = [UIColor brownColor];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:passwordLabel];
    
    // 6、密码输入框
    UITextField *passwordTextField = [[UITextField alloc] init];
    self.passwordTextField = passwordTextField;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.font = [UIFont boldSystemFontOfSize:fontNum];
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]}];
    [self addSubview:passwordTextField];
    
    // 7、密码输入框下部白线
    UIView *passwordLineView = [[UIView alloc] init];
    self.passwordLineView = passwordLineView;
    passwordLineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:passwordLineView];
    
    // 8、密码输入框右侧眼睛图标
    UIImageView *eyeImageView = [[UIImageView alloc] init];
    self.eyeImageView = eyeImageView;
    eyeImageView.image = [UIImage imageNamed:@"denglu_yanjing2"];
    [self addSubview:eyeImageView];
    
    UIButton *eyeButton = [[UIButton alloc] init];
    self.eyeButton = eyeButton;
    [eyeButton addTarget:self action:@selector(eyeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:eyeButton];
    
    // 9、登录按钮
    UIButton *loginButton = [[UIButton alloc] init];
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
    [self addSubview:loginButton];
    
    // 10、注册按钮
    UIButton *registerButton = [[UIButton alloc] init];
    self.registerButton = registerButton;
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontNum];
    [registerButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
}

#pragma mark 设置子控件frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgBtn.frame = self.frame;
    
    CGFloat labelX = 45.0;
    CGFloat labelY = 102.0;
    CGFloat labelHeight = 44.0;
    CGFloat textFieldWidth = 175.0;
    //    //适配6+
    //    if (iPhone6Plus) {
    //        textFieldWidth = 240;
    //    }
    self.usernameLabel.frame = CGRectMake(labelX+15, labelY, 40, labelHeight);
    self.usernameTextField.frame = CGRectMake(labelX + self.usernameLabel.width + 30, labelY, textFieldWidth, labelHeight);
    self.usernameLineView.frame = CGRectMake(labelX, self.usernameLabel.y + self.usernameLabel.height, MAINSCREEN_WIDTH - 90, 0.5);
    
    self.passwordLabel.frame = CGRectMake(labelX + 15, self.usernameLineView.y + self.usernameLineView.height, 40, labelHeight);
    self.passwordTextField.frame = CGRectMake(labelX + self.passwordLabel.width+30, self.usernameLineView.y + self.usernameLineView.height, textFieldWidth - 30, labelHeight);
    self.passwordLineView.frame = CGRectMake(self.usernameLineView.x, self.passwordLabel.y + self.passwordLabel.height, MAINSCREEN_WIDTH - 90, 0.5);
    
    
    self.eyeImageView.frame = CGRectMake(MAINSCREEN_WIDTH - 71, self.usernameLineView.y + self.usernameLineView.height + (labelHeight-12)/2, 21, 12);
    self.eyeButton.frame = CGRectMake(MAINSCREEN_WIDTH-81, self.usernameLineView.y + self.usernameLineView.height + 5, 40, 32);
    
    self.loginButton.frame = CGRectMake(self.passwordLineView.x, self.passwordLineView.y + self.passwordLineView.height + labelHeight, MAINSCREEN_WIDTH - 90, labelHeight);
    
    self.registerButton.frame = CGRectMake((MAINSCREEN_WIDTH - 120)/2, self.loginButton.y + self.loginButton.height + labelHeight * 3 / 2, 120, 30);
    
}

#pragma mark 子控件点击事件处理
- (void)backgroundButtonClick:(UIButton *)bgBtn
{
    if ([self.delegate respondsToSelector:@selector(loginBgViewWithBgBtnClicked:)])
    {
        [self.delegate loginBgViewWithBgBtnClicked:bgBtn];
    }
}

- (void)eyeButtonClick:(UIButton *)eyeBtn
{
    if ([self.delegate respondsToSelector:@selector(loginBgViewWithEyeBtnClicked:imageView:passwordTextF:)])
    {
        [self.delegate loginBgViewWithEyeBtnClicked:eyeBtn imageView:self.eyeImageView passwordTextF:self.passwordTextField];
    }
}

- (void)loginBtnClick:(UIButton *)LoginBtn
{
    if ([self.delegate respondsToSelector:@selector(loginBgViewWithloginBtnClicked:usernameTextF:passwordTextF:)])
    {
        [self.delegate loginBgViewWithloginBtnClicked:LoginBtn usernameTextF:self.usernameTextField passwordTextF:self.passwordTextField];
    }
}

- (void)registerBtnClick:(UIButton *)registerBtn
{
    if ([self.delegate respondsToSelector:@selector(loginBgViewWithRegisterBtnClicked:)])
    {
        [self.delegate loginBgViewWithRegisterBtnClicked:registerBtn];
    }
}

@end
