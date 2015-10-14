//
//  UIWindow+Extension.m
//  openBridge
//
//  Created by doubin on 15/9/1.
//  Copyright (c) 2015年 harmazing. All rights reserved.
//

#import "UIWindow+Extension.h"
//#import "HMCTabBarController.h"

@implementation UIWindow (Extension)

- (void)chooseRootviewController
{
    // 判断应用显示新特性还是欢迎界面
    // 1.获取沙盒中的版本号
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *key = @"CFBundleShortVersionString";
//    NSString *sandboxVersion = [defaults objectForKey:key];
//    
//    // 2.获取软件当前的版本号
//    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
//    NSString *currentVersion = dict[key];
//    
//    // 3.比较沙盒中的版本号和软件当前的版本号
//    if([currentVersion compare:sandboxVersion] == NSOrderedDescending )
//    {
//        // 显示新特性
//        self.rootViewController = [[HWNewfeatureViewController alloc] init];
//        
//        // 存储软件当前的版本号
//        [defaults setObject:currentVersion forKey:key];
//        [defaults synchronize];
//        
//    }else
//    {
        //
    
//    self.rootViewController = [[HMCTabBarController alloc] init];


//    }
}

@end
