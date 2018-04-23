//
//  ViewController.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "ZProgressHUD.h"

@implementation ZProgressHUD

+ (ZProgressHUD *)shareManager
{
    static ZProgressHUD *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[ZProgressHUD alloc]init];
        shareManager.zProgressView = [[ZProgressView alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:shareManager.zProgressView];
    });
    return shareManager;
}

- (void)showWithMessage:(NSString *)message type:(ZProgressHUDType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.zProgressView show];
        [self.zProgressView hudShowWithType:type message:message];
    });
}
- (void)dismissWithTime:(NSInteger )time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.zProgressView dismiss];
        });
    });

}

@end
