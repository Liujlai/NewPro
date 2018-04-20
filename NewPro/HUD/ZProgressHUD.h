//
//  ViewController.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZProgressView.h"
@interface ZProgressHUD : NSObject

@property (nonatomic,strong) ZProgressView *zProgressView;
@property (nonatomic,assign) ZProgressHUDType type;
+ (ZProgressHUD *)shareManager;

- (void)showWithMessage:(NSString *)message type:(ZProgressHUDType)type;
- (void)dismissWithTime:(NSInteger )time;

@end
