//
//  XKCInteractiveTransition.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/29.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCInteractiveTransition.h"

@interface XKCInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;

@property (nonatomic, strong) UIViewController *presentingVC;

@end

@implementation XKCInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController{
    
    self.presentingVC = viewController;
    
    // 给vc.view 添加滑动手势
    UIGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    [viewController.view addGestureRecognizer:panGes];
    
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture{
    
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            // 这句代码很重要 dismiss会触发animation代理方法 animation方法一定条件下触发interactive代理方法
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.y / 400.0;
            
            //Limit it between 0 and 1
            fraction = MIN(MAX(fraction, 0.0), 1.0);
            
            self.shouldComplete = (fraction > 0.5);
            //  从效果上来看就是 View根据手势的来移动
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            // 检查是否应该发生transition
            self.interacting = NO;
            if (!self.shouldComplete) {
                // 这俩个方法 cancle finsh 一定要调用 不然就不动了
                
                // 取消transition
                [self cancelInteractiveTransition];
            } else {
                // 执行transition
                [self finishInteractiveTransition];
            }
            
            break;
        }
        default:
            break;
    }
}


@end
