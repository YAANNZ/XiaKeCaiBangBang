//
//  XKCRootBottomView.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCRootBottomView.h"

@interface XKCRootBottomView ()

@property (nonatomic,weak) UIButton *menuBtn;
@property (nonatomic,weak) UIButton *settingBtn;

@end

@implementation XKCRootBottomView

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
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.menuBtn = menuBtn;
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_icon_categories"] forState:UIControlStateNormal];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_icon_categories"] forState:UIControlStateSelected];
    [menuBtn addTarget:self action:@selector(menuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.settingBtn = settingBtn;
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_icon_settings"] forState:UIControlStateNormal];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_icon_settings"] forState:UIControlStateHighlighted];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
    
    UISegmentedControl *sgControl = [[UISegmentedControl alloc] initWithItems:@[@"帮会暗语", @"帮会大厅"]];
    self.sgControl = sgControl;
    [sgControl setTitleTextAttributes:@{
                                        NSForegroundColorAttributeName: [UIColor grayColor]
                                        } forState:UIControlStateNormal];
    [sgControl setTitleTextAttributes:@{
                                        NSForegroundColorAttributeName: [UIColor whiteColor]
                                        } forState:UIControlStateSelected];
    sgControl.tintColor = [UIColor grayColor];
    [sgControl setSelectedSegmentIndex:0];
    [sgControl addTarget:self action:@selector(sgControlClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:sgControl];
}

#pragma mark 设置子控件frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    int menuBtnWidth = 24;
    int menuBtnHeight = 24;
    int menuBtnY = (self.height - menuBtnHeight) * 0.5;
    int menuBtnX = self.width - menuBtnWidth - menuBtnY;
    self.menuBtn.frame = CGRectMake(menuBtnX, menuBtnY, menuBtnWidth, menuBtnHeight);
    
    int settingBtnW = 24;
    int settingBtnH = 24;
    int settingBtnY = menuBtnY;
    int settingBtnX = settingBtnY;
    self.settingBtn.frame = CGRectMake(settingBtnX, settingBtnY, settingBtnW, settingBtnH);
    
    int sgControlW = 130;
    int sgControlH = 30;
    int sgControlX = (self.width - sgControlW) * 0.5;
    int sgControlY = (self.height - sgControlH) * 0.5;
    self.sgControl.frame = CGRectMake(sgControlX, sgControlY, sgControlW, sgControlH);
}

#pragma mark 子控件点击事件处理
- (void)menuBtnClick
{
    if ([self.delegate respondsToSelector:@selector(bottomViewForWeatherButtonClick)])
    {
        [self.delegate bottomViewForWeatherButtonClick];
    }
}

- (void)settingBtnClick
{
    if ([self.delegate respondsToSelector:@selector(bottomViewForSettingBtnClick)])
    {
        [self.delegate bottomViewForSettingBtnClick];
    }
}

- (void)sgControlClick:(UISegmentedControl *)sgControl
{
    if ([self.delegate respondsToSelector:@selector(bottomViewForSgControlClick:)])
    {
        [self.delegate bottomViewForSgControlClick:self.sgControl];
    }
}




@end
