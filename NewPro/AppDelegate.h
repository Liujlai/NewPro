//
//  AppDelegate.h
//  NewPro
//
//  Created by idea on 2018/4/17.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//加载所有的视图控制器
-(void)loadAllViewController;
//加载登录视图控制器
-(void)loadLoginViewController;
@end

