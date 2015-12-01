//
//  XKCLoginViewController.h
//  XiaKeCBB
//
//  Created by doubin on 15/10/14.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKCLoginViewController;

@protocol XKCLoginViewControllerDelegate <NSObject>
@optional
- (void)loginViewController:(XKCLoginViewController *)loginViewController loginSuccessWithUsername:(NSString *)username password:(NSString *)password;
@end

@interface XKCLoginViewController : UIViewController

@property (nonatomic, weak) id<XKCLoginViewControllerDelegate> delegate;

@end
