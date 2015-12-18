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
    // 1、准备数据
    NSInteger margin = 20;
    NSInteger widthMargin = 5;
    NSInteger heightMargin = 10;
    NSInteger fontNum = 18;
    NSInteger borderWidth = 2;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontNum]};
    CGSize contentMaxSize = CGSizeMake(30, self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin);
    // 计算宽高
    for (XKCArgotModel *dataModel in self.dataArray)
    {
        CGSize queSize = [dataModel.question boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        dataModel.queLableW = queSize.width;
        dataModel.queLableH = queSize.height;
        
        CGSize ansSize = [dataModel.answer boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        dataModel.answerLableW = ansSize.width;
        dataModel.answerLableH = ansSize.height;
    }
    
    // 2、创建问题和答案控件
#warning goto 计算问题和答案的长度是否超出显示范围
    UILabel *questionL = [[UILabel alloc] init];
    questionL.numberOfLines = 0;
    questionL.text = self.qusAndAnswer.question;
    questionL.textColor = XKCBaseColor;
    questionL.font = [UIFont systemFontOfSize:fontNum];
    questionL.textAlignment = NSTextAlignmentCenter;
    questionL.width = self.qusAndAnswer.queLableW + widthMargin;
    questionL.height = self.qusAndAnswer.queLableH + heightMargin;
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
    
    // 3、创建答案选项控件
    NSInteger columnIndex = 0;
    NSInteger remainderH = (NSInteger)(self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin);
    for (XKCArgotModel *dataModel in self.dataArray)
    {
        // 判断是否还有空间
        if((margin + (columnIndex + 1) * (margin/2 + dataModel.answerLableW + widthMargin) + dataModel.answerLableW + widthMargin + margin) > self.view.width)
        {
            break;
        }
        UILabel *optionL = [[UILabel alloc] init];
        optionL.width = dataModel.answerLableW + widthMargin;
        optionL.height = dataModel.answerLableH + heightMargin;
        if ((remainderH == (NSInteger)(self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin)) && (columnIndex == 0))
        {
            optionL.x = margin;
            optionL.y = margin + XKCNavBarHeight;
            remainderH = remainderH - optionL.height - margin/2;
        }
        else
        {
            if(remainderH < (NSInteger)(self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin))
            {
                if (optionL.height <= remainderH)
                {
                    optionL.x = margin + columnIndex * (margin/2 + optionL.width);
                    optionL.y = self.view.height - (remainderH + margin + XKCTabBarHeight);
                    remainderH = remainderH - optionL.height - margin/2;
                }
                else
                {
                    columnIndex++;
                    optionL.x = margin + columnIndex * (margin/2 + optionL.width);
                    optionL.y = margin + XKCNavBarHeight;
                    remainderH = (NSInteger)(self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin - optionL.height -margin/2);
                }
            }
        }
        optionL.numberOfLines = 0;
        optionL.text = dataModel.answer;
        optionL.textColor = XKCBaseColor;
        optionL.font = [UIFont systemFontOfSize:fontNum];
        optionL.textAlignment = NSTextAlignmentCenter;
        optionL.layer.cornerRadius = answerL.width/2;
        optionL.layer.masksToBounds = YES;
        optionL.backgroundColor = [UIColor orangeColor];
        optionL.userInteractionEnabled = YES;
        [self.view addSubview:optionL];
        UIGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [optionL addGestureRecognizer:panGes];
    }
}


- (void)handleGesture:(UIPanGestureRecognizer *)gesture
{
    UILabel *selLable = (UILabel *)gesture.view;
    CGPoint translation = [gesture translationInView:selLable.superview];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.selAnswerL = selLable;
            self.corAnswerLOrigin = selLable.origin;
            self.answerLH = self.answerL.height;
            break;
        case UIGestureRecognizerStateChanged: {
            selLable.transform = CGAffineTransformIdentity;
            selLable.transform = CGAffineTransformTranslate(selLable.transform, translation.x, translation.y);
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 判断位置
            if (selLable.x > self.answerL.x - self.answerL.width)
            {
                // 判断答案
                if ([selLable.text isEqualToString:self.qusAndAnswer.answer])
                {
                    [UIView animateWithDuration:1.0 animations:^{
                        selLable.transform = CGAffineTransformIdentity;
                        selLable.x = self.answerL.x + 2;
                        selLable.y = self.answerL.y + 2;
                    }];
                    [UIView animateWithDuration:2.0 animations:^{
                        self.answerL.height = selLable.height + 4;
                    }completion:^(BOOL finished) {
                        selLable.transform = CGAffineTransformIdentity;
                        // 切换主屏幕
                        if([self.delegate respondsToSelector:@selector(argotViewControllerDismissWithCorrectAnswer:)])
                        {
                            [self.delegate argotViewControllerDismissWithCorrectAnswer:self];
                        }
                    }];
                }
                else
                {
                    selLable.transform = CGAffineTransformIdentity;
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

- (void)nextQuestion
{
    XKCArgotModel *newQusAndAnswer = self.dataArray[arc4random_uniform((int)self.dataArray.count)];
    self.questionL.text = newQusAndAnswer.question;
    [UIView animateWithDuration:1.0 animations:^{
        self.questionL.height += newQusAndAnswer.queLableH - self.qusAndAnswer.queLableH;
        self.answerL.height -= newQusAndAnswer.queLableH - self.qusAndAnswer.queLableH;
        self.answerL.y += newQusAndAnswer.queLableH - self.qusAndAnswer.queLableH;
    }];
    self.qusAndAnswer = newQusAndAnswer;
    
}


#pragma mark - 懒加载
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
                          @"question": @"侠骨千年寻不见，",
                          @"answer": @"碧血红叶醉秋风。"
                          },
                        @{
                          @"question": @"人生在世，追求的是希望，",
                          @"answer": @"但是得到的只有回忆。"
                          },
                        @{
                          @"question": @"人就是江湖，",
                          @"answer": @"你怎么退出？"
                          }];
        _dataArray = [XKCArgotModel objectArrayWithKeyValuesArray:array];
    }
    return _dataArray;
}

- (XKCArgotModel *)qusAndAnswer
{
    if (_qusAndAnswer == nil)
    {
        _qusAndAnswer = self.dataArray[arc4random_uniform((int)self.dataArray.count)]; // 随机获取提问用问题
    }
    return _qusAndAnswer;
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
