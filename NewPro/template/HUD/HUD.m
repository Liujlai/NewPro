//
//  ViewController.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "HUD.h"
#import "ZProgressHUD.h"

@implementation HUD


+(void)showSuccess :(NSString*)status
{
    [[ZProgressHUD shareManager] showWithMessage:status type:ZProgressHUDTypeSuccess];
    
    [[ZProgressHUD shareManager] dismissWithTime:1.2];
}
+(void)showError :(NSString*)status
{
    [[ZProgressHUD shareManager] showWithMessage:status type:ZProgressHUDTypeError];
    [[ZProgressHUD shareManager] dismissWithTime:1.2];
}
+(void)showLoading :(NSString*)status
{
    [[ZProgressHUD shareManager] showWithMessage:status type:ZProgressHUDTypeLoading];
    //    加载一般为五秒，如过5秒内加载完成需手动关闭，如果5秒外将自动关闭，请求超时
    [[ZProgressHUD shareManager] dismissWithTime:5];
}
+(void)showInfo :(NSString*)status
{
    [[ZProgressHUD shareManager] showWithMessage:status type:ZProgressHUDTypeMessage];
    [[ZProgressHUD shareManager] dismissWithTime:1.2];
}
+(void)dismiss
{
    [[ZProgressHUD shareManager] dismissWithTime:0];
}
@end
