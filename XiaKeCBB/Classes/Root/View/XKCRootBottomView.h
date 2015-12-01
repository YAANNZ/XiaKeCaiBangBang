//
//  XKCRootBottomView.h
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKCRootBottomViewDelegate <NSObject>

- (void)bottomViewForWeatherButtonClick;
- (void)bottomViewForSettingBtnClick;
- (void)bottomViewForSgControlClick:(UISegmentedControl *)sgControl;

@end

@interface XKCRootBottomView : UIView
@property (nonatomic, weak) id <XKCRootBottomViewDelegate> delegate;
@end
