//
//  XKCInteractiveTransition.h
//  XiaKeCBB
//
//  Created by doubin on 15/11/29.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKCInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewController;

@end
