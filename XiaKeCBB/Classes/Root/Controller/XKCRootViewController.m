//
//  XKCRootViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCRootViewController.h"
#import "XKCArgotViewController.h"
#import "XKCMainViewController.h"
#import "XKCRootBottomView.h"
#import "XKCSettingTableViewController.h"
#import "XKCWeatherViewController.h"
#import "XKCPresentAnimation.h"
#import "XKCDismissAnimation.h"
#import "XKCInteractiveTransition.h"
#import "XKCCustomView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface XKCRootViewController () <XKCRootBottomViewDelegate, UIViewControllerTransitioningDelegate, XKCArgotViewControllerDelegate>

@property (nonatomic,weak) XKCRootBottomView *bottomView;
@property (nonatomic, strong) XKCPresentAnimation *presentAnimation;
@property (nonatomic, strong) XKCDismissAnimation *dismissAnimation;
@property (nonatomic, strong) XKCInteractiveTransition *interactiveTransition;
@property (nonatomic, weak) XKCArgotViewController *argotVC;
//@property (nonatomic, assign) BOOL couldDis;

@end

@implementation XKCRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"侠客菜帮帮", @"123");
    
    /** 设置导航栏背景颜色，字体，状态栏颜色 */
    NSDictionary *navAttrDict = @{
                                  NSForegroundColorAttributeName : [UIColor orangeColor]
                                  // 设置字体大小
                                  };
    [self.navigationController.navigationBar setBarTintColor:XKCBaseColor];
    [self.navigationController.navigationBar setTitleTextAttributes:navAttrDict];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 添加子控制器
    XKCArgotViewController *argotVC = [[XKCArgotViewController alloc] init];
    argotVC.delegate = self;
    self.argotVC = argotVC;
    [self addChildViewController:argotVC];
    XKCMainViewController *mainVC = [[XKCMainViewController alloc] init];
    [self addChildViewController:mainVC];
    [self.view addSubview:argotVC.view];
    mainVC.view.frame = CGRectMake(self.view.width, 0, self.view.width, self.view.height);
    [self.view addSubview:mainVC.view];
    
    // 添加下部view
    XKCRootBottomView *bottomView = [[XKCRootBottomView alloc] init];
    self.bottomView = bottomView;
    bottomView.frame = CGRectMake(0, self.view.height - XKCTabBarHeight, self.view.width, XKCTabBarHeight);
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    
    // 添加nav右侧item
    UIButton *nextItem = [UIButton buttonWithType:UIButtonTypeCustom];
    nextItem.frame = CGRectMake(0, 0, 40, 20);
    nextItem.layer.cornerRadius = 5;
    [nextItem setTitle:@"next" forState:UIControlStateNormal];
    [nextItem setBackgroundColor:[UIColor orangeColor]];
    [nextItem addTarget:self action:@selector(nextQuestion) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextItem];
    
    // 摇一摇
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self resignFirstResponder];
}

- (void)nextQuestion
{
    [self.argotVC nextQuestion];
}

#pragma mark - XKCRootBottomViewDelegate方法
- (void)bottomViewForWeatherButtonClick
{
    XKCWeatherViewController *weatherVC = [[XKCWeatherViewController alloc] init];
    weatherVC.transitioningDelegate = self; // 添加自定义modal动画
    [self.interactiveTransition wireToViewController:weatherVC]; // 添加手势滑动dismiss的动画
    [self presentViewController:weatherVC animated:YES completion:nil];
}

- (void)bottomViewForSettingBtnClick
{
    XKCSettingTableViewController *settingVC = [[XKCSettingTableViewController alloc] init];
    settingVC.transitioningDelegate = self;
    [self.interactiveTransition wireToViewController:settingVC];
    [self presentViewController:settingVC animated:YES completion:nil];
}

- (void)bottomViewForSgControlClick:(UISegmentedControl *)sgControl
{
    if (sgControl.selectedSegmentIndex == 0)
    {
        XKCLog(@"帮会暗语");
        // 显示XKCArgotViewController
        if (self.view.subviews[0].x)
        {
            [UIView animateWithDuration:1.0 animations:^{
                self.navigationItem.rightBarButtonItem.customView.alpha = 1;
                self.view.subviews[0].x = 0;
                self.view.subviews[1].x = self.view.width;
            }];
        }
    }
    else
    {
        XKCLog(@"帮会大厅");
        LAContext *context = [LAContext new];
        NSError *error;
        context.localizedFallbackTitle = @"侠客菜帮帮";
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
        {
            NSLog(@"Touch ID is available.");
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:NSLocalizedString(@"开启符文吧，少侠！", nil)
                              reply:^(BOOL success, NSError *error) {
                                  if (success)
                                  {
                                      [UIView animateWithDuration:1.0 animations:^{
                                          self.view.subviews[1].x = 0;
                                          self.view.subviews[0].x = -self.view.width;
                                          self.navigationItem.rightBarButtonItem.customView.alpha = 0;
                                      }completion:^(BOOL finished) {
                                          self.argotVC.answerL.height = self.argotVC.answerLH;
                                          self.argotVC.selAnswerL.origin = self.argotVC.corAnswerLOrigin;
                                      }];
                                  }
                                  else
                                  {
                                      if (error.code == kLAErrorUserFallback)
                                      {
                                          NSLog(@"User tapped Enter Password");
                                      } else if (error.code == kLAErrorUserCancel) {
                                          NSLog(@"User tapped Cancel");
                                      } else {
                                          NSLog(@"Authenticated failed.");
                                      }
                                  }
                              }
             ];
        }
        else
        {
            NSLog(@"Touch ID is not available: %@", error);
        }
    }
}

#pragma - mark  XKCArgotViewControllerDelegate
- (void)argotViewControllerDismissWithCorrectAnswer:(UIViewController *)VC
{
    [self.bottomView.sgControl setSelectedSegmentIndex:1];
    [UIView animateWithDuration:1.0 animations:^{
        self.view.subviews[1].x = 0;
        self.view.subviews[0].x = -self.view.width;
        self.navigationItem.rightBarButtonItem.customView.alpha = 0;
    }completion:^(BOOL finished) {
        self.argotVC.answerL.height = self.argotVC.answerLH;
        self.argotVC.selAnswerL.origin = self.argotVC.corAnswerLOrigin;
    }];
}

#pragma - mark  UIViewControllerTransitioningDelegate
// modal 时调用此方法
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

// dismiss 时调用此方法
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

// 只有第二个方法不返回nil时 才会触发此方法
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    // 根据实际情况 确定是否返回interactiveTransition对象
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}

#pragma mark - 懒加载
- (XKCPresentAnimation *)presentAnimation
{
    if (_presentAnimation == nil)
    {
        _presentAnimation = [[XKCPresentAnimation alloc] init];
    }
    return _presentAnimation;
}

- (XKCDismissAnimation *)dismissAnimation
{
    if (_dismissAnimation == nil)
    {
        _dismissAnimation = [[XKCDismissAnimation alloc] init];
    }
    return _dismissAnimation;
}

- (XKCInteractiveTransition *)interactiveTransition
{
    if (_interactiveTransition == nil)
    {
        _interactiveTransition = [[XKCInteractiveTransition alloc] init];
    }
    return _interactiveTransition;
}

#pragma mark - 摇一摇
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
//        XKCLog(@"摇一摇");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        XKCLog(@"摇一摇取消");
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        XKCLog(@"摇一摇结束");
        //自定义动画效果
        [self fallXiaKeCBBText];
    }
}


- (void)fallXiaKeCBBText
{
    NSMutableArray *lableArray = [NSMutableArray array];
    int lableW = 60;
    int lableH = 60;
    int lableX = (self.view.width - lableW)/2;
    int lableY = -lableH;
    for (int i = 0; i < 5; i++)
    {
        XKCCustomView *XLable = [[XKCCustomView alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
        NSString *str = @"侠客菜帮帮";
        XLable.text = [str substringWithRange:NSMakeRange(i, 1)];
        XLable.backgroundColor = XKCBaseColor;
        [self.view addSubview:XLable];
        [lableArray addObject:XLable];
    }
    [self animateWithLableArray:lableArray withIndex:0];
}

- (void)animateWithLableArray:(NSMutableArray *)lableArray withIndex:(int)index
{
    XKCCustomView *lableView = (XKCCustomView *)lableArray[index];
    index++;
    [UIView animateWithDuration:0.5 animations:^{
        lableView.y = self.view.height/2 - lableView.height/2;
    } completion:^(BOOL finished) {
        if (index < lableArray.count)
        {
            [self animateWithLableArray:lableArray withIndex:index];
        }
        [UIView animateWithDuration:0.5 animations:^{
            lableView.x = (arc4random_uniform(2)%2) == 0?-lableView.width:self.view.width;
        } completion:^(BOOL finished) {
            [lableView removeFromSuperview];
        }];
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
