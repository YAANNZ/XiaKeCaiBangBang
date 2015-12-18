//
//  XKCSettingTableViewController.m
//  XiaKeCBB
//
//  Created by doubin on 15/11/24.
//  Copyright © 2015年 xiakecbb. All rights reserved.
//

#define XKCAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "XKCSettingTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface XKCSettingTableViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation XKCSettingTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 第一组
    [self setUpGroup0];
    
    
    // 第二组
    [self setUpGroup1];
    
    // 第三组
    [self setUpGroup2];
}

// 添加第0组
- (void)setUpGroup0
{
    XKCSettingItem *userinfo = [[XKCSettingItem alloc] init];
    userinfo.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    userinfo.cellStyle = UITableViewCellStyleDefault;
    userinfo.cellHeight = @"50";
    userinfo.title = @"修改个人信息";
    
    XKCSettingItem *password = [[XKCSettingItem alloc] init];
    password.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    password.cellStyle = UITableViewCellStyleDefault;
    password.cellHeight = @"50";
    password.title = @"修改密码";
    
    XKCSettingItem *logout = [[XKCSettingItem alloc] init];
    logout.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    logout.cellStyle = UITableViewCellStyleDefault;
    logout.cellHeight = @"50";
    logout.title = @"退出登录";
    logout.option = ^(NSIndexPath *indexPath){
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        if ([defaultManager isDeletableFileAtPath:XKCAccountPath]){
            BOOL success = [defaultManager removeItemAtPath:XKCAccountPath error:nil];
            XKCLog(@"退出登录-－%d",success);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    XKCGroupItem *group0 = [XKCGroupItem groupWithItems:[NSMutableArray arrayWithObjects:userinfo, password, logout, nil]];
    [self.groups addObject:group0];
    
}

- (void)setUpGroup1
{
    XKCSettingItem *cleanCache = [[XKCSettingItem alloc] init];
    cleanCache.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cleanCache.cellStyle = UITableViewCellStyleDefault;
    cleanCache.cellHeight = @"50";
    cleanCache.title = @"清除缓存";
    
    XKCGroupItem *group1 = [XKCGroupItem groupWithItems:[NSMutableArray arrayWithObjects:cleanCache, nil]];
    [self.groups addObject:group1];
}

- (void)setUpGroup2
{
    XKCSettingItem *feedback = [[XKCSettingItem alloc] init];
    feedback.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    feedback.cellStyle = UITableViewCellStyleDefault;
    feedback.cellHeight = @"50";
    feedback.title = @"意见反馈";
    
    XKCSettingItem *appraise = [[XKCSettingItem alloc] init];
    appraise.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    appraise.cellStyle = UITableViewCellStyleDefault;
    appraise.cellHeight = @"50";
    appraise.title = @"评价我们";
    appraise.subTitle = @"zhuynchn@163.com";
    
    XKCSettingItem *service = [[XKCSettingItem alloc] init];
    service.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    service.cellStyle = UITableViewCellStyleDefault;
    service.cellHeight = @"50";
    service.title = @"服务条款";
    
    XKCSettingItem *aboutUs = [[XKCSettingItem alloc] init];
    aboutUs.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    aboutUs.cellStyle = UITableViewCellStyleDefault;
    aboutUs.cellHeight = @"50";
    aboutUs.title = @"关于";
    aboutUs.subTitle = @"1.1.0";
    
    XKCGroupItem *group2 = [XKCGroupItem groupWithItems:[NSMutableArray arrayWithObjects:feedback, appraise, service, aboutUs, nil]];
    [self.groups addObject:group2];
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section)
//    {
//        case 0:
//            return @"帐号：";
//            break;
//            
//        case 1:
//            return @"设置";
//            break;
//            
//        case 2:
//            return @"支持";
//            break;
//            
//        default:
//            return nil;
//            break;
//    }
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (indexPath.section)
//    {
//        case 0:
//            switch (indexPath.row) {
//                case 0:
//                    XKCLog(@"修改个人信息");
//                    break;
//                case 1:
//                    XKCLog(@"修改密码");
//                    break;
//                case 2:
//                    XKCLog(@"退出登录");
//                    [self logout];
//                    break;
//                default:
//                    break;
//            }
//            break;
//            
//        case 1:
//            XKCLog(@"清除缓存");
//            break;
//            
//        case 2:
//            switch (indexPath.row) {
//                case 0:
//                    XKCLog(@"意见反馈");
//                    [self feedback];
//                    break;
//                case 1:
//                    XKCLog(@"评价我们");
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id967710424?mt=8"]]];
//                    break;
//                case 2:
//                    XKCLog(@"服务条款");
//                    break;
//                case 3:
//                    XKCLog(@"关于");
//                    break;
//                default:
//                    break;
//            }
//            break;
//            
//        default:
//            break;
//    }
//}
//
//
//#pragma mark - cell的点击事件处理
//- (void)logout
//{
//    // 退出登录
//    NSFileManager *defaultManager = [NSFileManager defaultManager];
//    if ([defaultManager isDeletableFileAtPath:XKCAccountPath]){
//        BOOL success = [defaultManager removeItemAtPath:XKCAccountPath error:nil];
//        XKCLog(@"退出登录-－%d",success);
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//// 发送邮件
//- (void)feedback
//{
//    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
//    mailPicker.mailComposeDelegate = self;
//    [mailPicker setSubject:@"反馈给侠客菜帮帮"]; //邮件主题
//    [mailPicker setToRecipients:[NSArray arrayWithObjects:@"zhuynchn@163.com", nil]]; //设置发送给谁，参数是NSarray
//    [mailPicker setMessageBody:@"并没有意见!" isHTML:NO]; //邮件内容
//    [self presentViewController:mailPicker animated:YES completion:nil];
//}
//
//#pragma mark -  MFMailComposeViewControllerDelegate
//// 发送或者取消发送的时候回调
//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result                  error:(NSError*)error
//{
//    switch (result){
//        case MFMailComposeResultCancelled:
//            NSLog(@"发送取消");
//            break;
//            
//        case MFMailComposeResultSaved:
//            NSLog(@"保存草稿");
//            break;
//            
//        case MFMailComposeResultSent:
//            NSLog(@"已发送");
//            break;
//            
//        case MFMailComposeResultFailed:
//            NSLog(@"发送失败:%@", [error localizedDescription]);
//            break;
//            
//        default:
//            break;
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
//}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
