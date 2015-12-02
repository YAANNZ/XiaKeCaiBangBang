//
//  XKCArgotViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCArgotViewController.h"
#import "UILabel+Extension.h"
#import "XKCArgotModel.h"

@interface XKCArgotViewController ()

@property (nonatomic, weak) UILabel *questionL;
@property (nonatomic, weak) UILabel *answerL;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) XKCArgotModel *qusAndAnswer;

@end

@implementation XKCArgotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = XKCBaseColor;
    
    [self setupSubviews];
    
}

- (void)setupSubviews
{
    NSInteger margin = 20;
    NSInteger widthMargin = 5;
    NSInteger heightMargin = 10;
    NSInteger fontNum = 18;
    NSInteger borderWidth = 2;
    UILabel *questionL = [[UILabel alloc] init];
    questionL.text = @"我们的口号是，";
    questionL.textColor = XKCBaseColor;
    questionL.font = [UIFont systemFontOfSize:fontNum];
    questionL.textAlignment = NSTextAlignmentCenter;
    questionL.size = [questionL boundingRectWithSize:CGSizeMake(30, (self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin)/2)];
    questionL.width += widthMargin;
    questionL.height += heightMargin;
    questionL.x = self.view.width - questionL.width - margin;
    questionL.y = margin + XKCNavBarHeight;
    questionL.layer.cornerRadius = questionL.width/2;
    questionL.layer.masksToBounds = YES;
    questionL.backgroundColor = [UIColor orangeColor];
    self.questionL = questionL;
    [self.view addSubview:questionL];
    
    UILabel *answerL = [[UILabel alloc] init];
    answerL.frame = CGRectMake(questionL.x - borderWidth, margin + CGRectGetMaxY(questionL.frame), questionL.width + 2*borderWidth, self.view.height - XKCTabBarHeight - CGRectGetMaxY(questionL.frame) - 2*margin);
    answerL.layer.cornerRadius = answerL.width/2;
    answerL.layer.borderWidth = borderWidth + 1; // +1修复合并空隙
    answerL.layer.borderColor = [UIColor orangeColor].CGColor;
    answerL.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.answerL = answerL;
    [self.view addSubview:answerL];
    
    UILabel *optionL = [[UILabel alloc] init];
    optionL.text = @"没有蛀牙！";
    optionL.textColor = XKCBaseColor;
    optionL.font = [UIFont systemFontOfSize:fontNum];
    optionL.textAlignment = NSTextAlignmentCenter;
    optionL.size = [optionL boundingRectWithSize:CGSizeMake(30, self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin)];
    optionL.width += widthMargin;
    optionL.height += heightMargin;
    optionL.x = margin;
    optionL.y = margin + XKCNavBarHeight;
    optionL.layer.cornerRadius = answerL.width/2;
    optionL.layer.masksToBounds = YES;
    optionL.backgroundColor = [UIColor orangeColor];
    optionL.userInteractionEnabled = YES;
    [self.view addSubview:optionL];
    UIGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [optionL addGestureRecognizer:panGes];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture
{
    UILabel *selLable = (UILabel *)gesture.view;
    CGPoint translation = [gesture translationInView:selLable.superview];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:

            break;
        case UIGestureRecognizerStateChanged: {
            XKCLog(@"%f",translation.y);
            selLable.transform = CGAffineTransformIdentity;
            selLable.transform = CGAffineTransformTranslate(selLable.transform, translation.x, translation.y);
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 判断位置
            XKCLog(@"%@",NSStringFromCGRect(selLable.frame));
            if (selLable.x > self.answerL.x - self.answerL.width)
            {
                // 判断答案
                if ([selLable.text isEqualToString:@"没有蛀牙！"])
                {
                    [UIView animateWithDuration:1.0 animations:^{
                        selLable.x = self.answerL.x + 2;
                        selLable.y = self.answerL.y + 2;
                    }];
                    [UIView animateWithDuration:2.0 animations:^{
                        self.answerL.height = selLable.height + 4;
                    }];
                }
            }
            else
            {
                selLable.transform = CGAffineTransformIdentity;
            }
            break;
        }
        default:
            break;
    }
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSArray *array = @[@{
                           @"question": @"我们的口号是，",
                           @"answer": @"没有蛀牙！"
                           },
                        @{
                          @"question": @"有人就有恩怨，",
                          @"answer": @"有恩怨就有江湖。"
                          },
                        @{
                          @"question": @"你会轻功，",
                          @"answer": @"酒壶又不会。"
                          },
                        @{
                          @"question": @"人生如朝露，",
                          @"answer": @"难得酒逢知己。"
                          },
                        @{
                          @"question": @"夜雨八方战孤城，",
                          @"answer": @"平明剑气看刀声。"
                          },
                        @{
                          @"question": @"我是一个大魔头，",
                          @"answer": @"我的路我一个人走。"
                          },
                        @{
                          @"question": @"公道不在人心，",
                          @"answer": @"是非在乎实力。"
                          },
                        @{
                          @"question": @"Talk is cheap.",
                          @"answer": @"Show me the code."
                          },
                        @{
                          @"question": @"人生在世，追求的是希望，",
                          @"answer": @"但是得到的只有回忆。"
                          }];
        _dataArray = [XKCArgotModel objectArrayWithKeyValuesArray:array];
    }
    return _dataArray;
}



//一、
//二、有人就有恩怨，有恩怨就有江湖。人就是江湖，你怎么退出？
//三、你会轻功，酒壶又不会。
//四、人生如朝露，难得酒逢知己。
//五、夜雨八方战孤城，平明剑气看刀声。侠骨千年寻不见，碧血红叶醉秋风。
//六、云会散，梦会消。但是记忆是不会消失的。人生在世，追求的是希望，但是得到的只有回忆。
//七、我是一个大魔头，我的路我一个人走。
//八、公道不在人心，是非在乎实力。
//九、Talk is cheap. Show me the code.





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
