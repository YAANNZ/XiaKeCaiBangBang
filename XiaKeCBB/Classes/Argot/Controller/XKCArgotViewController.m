//
//  XKCArgotViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCArgotViewController.h"
#import "UILabel+Extension.h"

@interface XKCArgotViewController ()

@property (nonatomic, weak) UILabel *answerL;
@property (nonatomic, strong) NSMutableArray *dataArray;

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
//    NSInteger answerLW = 40;
//    NSInteger answerLH = self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin;
//    NSInteger answerLX = self.view.width - answerTW - margin;
//    NSInteger answerLY = margin + XKCNavBarHeight;
    UILabel *answerL = [[UILabel alloc] init];
    answerL.text = @"我们的口号是";
    answerL.textColor = XKCBaseColor;
    answerL.font = [UIFont systemFontOfSize:18];
    answerL.width = 30;
    answerL.size = [answerL boundingRectWithSize:CGSizeMake(answerL.width, (self.view.height - XKCTabBarHeight - XKCNavBarHeight - 2*margin)/2)];
    answerL.x = self.view.width - answerL.width - margin;
    answerL.y = margin + XKCNavBarHeight;
    answerL.layer.cornerRadius = answerL.width/2;
    answerL.layer.masksToBounds = YES;
    answerL.backgroundColor = [UIColor orangeColor];
    self.answerL = answerL;
    [self.view addSubview:answerL];
    
    
}




- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [NSMutableArray arrayWithObjects:@"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", @"我们的口号是没有蛀牙！", nil];
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
