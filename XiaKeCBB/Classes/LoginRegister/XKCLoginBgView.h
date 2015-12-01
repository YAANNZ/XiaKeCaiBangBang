//
//  XKCLoginBgView.h
//  XiaKeCBB
//
//  Created by doubin on 15/11/29.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKCLoginBgViewDelegate <NSObject>
- (void)loginBgViewWithBgBtnClicked:(UIButton *)bgBtn;
- (void)loginBgViewWithEyeBtnClicked:(UIButton *)eyeBtn imageView:(UIImageView *)imageV passwordTextF:(UITextField *)passwordTextF;
- (void)loginBgViewWithloginBtnClicked:(UIButton *)loginBtn usernameTextF:(UITextField *)usernameTextF passwordTextF:(UITextField *)passwordTextF;
- (void)loginBgViewWithRegisterBtnClicked:(UIButton *)registerBtn;
@end


@interface XKCLoginBgView : UIView

@property (nonatomic, weak) id <XKCLoginBgViewDelegate> delegate;

@end
