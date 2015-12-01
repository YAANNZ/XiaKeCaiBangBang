//
//  XKCWeatherViewController.m
//  XiaKeCBB
//
//  Created by ZHUYN on 15/11/2.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#import "XKCWeatherViewController.h"
#import "XKCWeatherStatusRequest.h"
#import "XKCWeatherStatusTool.h"
#import "XKCDayWeatherStatus.h"

@interface XKCWeatherViewController ()

@end

@implementation XKCWeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor brownColor];
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
//    lable.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:lable];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(self.view.width - 20 - 40, self.view.height - 20 - 30, 40, 30);
    dismissBtn.backgroundColor = XKCBaseColor;
    dismissBtn.layer.cornerRadius = 4.0;
    dismissBtn.layer.masksToBounds = YES;
    dismissBtn.layer.borderWidth = 0.5f;
    dismissBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    [dismissBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [dismissBtn setTitle:@"阅" forState:UIControlStateNormal];
    dismissBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    UIButton *addCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addCityBtn.frame = CGRectMake(20, self.view.height - 20 - 30, 40, 30);
    addCityBtn.backgroundColor = XKCBaseColor;
    addCityBtn.layer.cornerRadius = 4.0;
    addCityBtn.layer.masksToBounds = YES;
    addCityBtn.layer.borderWidth = 0.5f;
    addCityBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    [addCityBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [addCityBtn setTitle:@"add" forState:UIControlStateNormal];
    addCityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [addCityBtn addTarget:self action:@selector(addCityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCityBtn];
    
//    [self getData];
    
}

- (void)dismissBtnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCityBtnClick:(UIButton *)btn
{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor purpleColor];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)getData
{
    // 1.创建一个请求管理者
    XKCWeatherStatusRequest *request = [[XKCWeatherStatusRequest alloc] init];
    request.key = @"080bb98453dda71d25f7269a6a5f5371";
    request.cityname = @"北京";
    
    // 2.请求
    [XKCWeatherStatusTool statusWithParams:request success:^(XKCWeatherStatus *statusResult) {
        XKCLog(@"成功");
        XKCLog(@"%@",statusResult);
        NSDate *now = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyyMMdd";
        NSString *nowDateStr = [fmt stringFromDate:now];
        XKCLog(@"%@",nowDateStr);
        NSMutableArray *futureArray = [NSMutableArray array];
        for (int i = 0; i < statusResult.result.future.count; i++) {
            NSString *keyStr = [NSString stringWithFormat:@"day_%d",(nowDateStr.intValue + i)];
            NSDictionary *dict = statusResult.result.future[keyStr];
            XKCLog(@"%@",dict);
            [futureArray addObject:[XKCDayWeatherStatus objectWithKeyValues:dict]];
        }
        XKCLog(@"%@",futureArray);
//        lable.text = ((XKCDayWeatherStatus *)futureArray[0]).date;
        
    } failure:^(NSError *error) {
        XKCLog(@"失败");
        XKCLog(@"%@",error);
    }];
}












- (void)didReceiveMemoryWarning {
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
