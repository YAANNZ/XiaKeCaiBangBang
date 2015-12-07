//
//  XKCArgotViewController.h
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKCArgotViewController;
@protocol XKCArgotViewControllerDelegate <NSObject>

- (void)argotViewControllerDismissWithCorrectAnswer:(UIViewController *)VC;

@end

@interface XKCArgotViewController : UIViewController

@property (nonatomic, weak) id<XKCArgotViewControllerDelegate> delegate;
@property (nonatomic, weak) UILabel *selAnswerL;
@property (nonatomic, assign) CGPoint corAnswerLOrigin;
@property (nonatomic, assign) float answerLH;
@property (nonatomic, weak) UILabel *answerL;
- (void)nextQuestion;

@end
