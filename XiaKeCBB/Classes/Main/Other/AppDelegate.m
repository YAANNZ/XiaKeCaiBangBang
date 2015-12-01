//
//  AppDelegate.m
//  XiaKeCBB
//
//  Created by doubin on 15/10/10.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "AppDelegate.h"
#import "XKCRootViewController.h"
#import <BmobSDK/Bmob.h>
#import <SMS_SDK/SMS_SDK.h>
#import "XKCAccountTool.h"
#import "XKCKeychain.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[XKCRootViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    // mob短信验证
    [SMS_SDK registerApp:@"c1d7b8ded57c" withSecret:@"0b4f1ec198a2f850e5c7a1d6aba26946"];
    
    // Bmob后台
    [Bmob registerWithAppKey:@"b923113232d0f26eca7290467601040c"];
    
/*
环信相关功能版本二再添加
    // 初始化环信
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"XKC_apns_dev";
#else
    apnsCertName = @"XKC_apns_dis";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"xiakecaibangbang#xiakecbb" apnsCertName:apnsCertName otherConfig:@{kSDKConfigEnableConsoleLogger:@YES}];
    // 登录环信
    XKCAccount *account = [XKCAccountTool account];
    if (account)
    {
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:account.uid password:[XKCKeychain readPassWord] completion:^(NSDictionary *loginInfo, EMError *error) {
            if (!error && loginInfo) {
                XKCLog(@"环信登陆成功");
                // 设置自动登录
                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                
            } else {
                XKCLog(@"环信登陆失败");
                
            }
        } onQueue:nil];
    }
*/
 
/** 
 代码功能测试通过，功能暂时不要
    // 阻塞主线程1秒后唤醒，可以做一些网络请求操作
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0, NO);
    CFRunLoopStop(CFRunLoopGetCurrent());
 */
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[EaseMob sharedInstance] applicationDidEnterBackground:application]; // 环信相关
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [[EaseMob sharedInstance] applicationWillEnterForeground:application]; // 环信相关
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [[EaseMob sharedInstance] applicationWillTerminate:application]; // 环信相关
}

@end
