//
//  AppDelegate.m
//  NewPro
//
//  Created by idea on 2018/4/17.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "AppDelegate.h"
#import "TabViewController.h"
#import "LaunchIntroductionView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSString *token = [DEFAULTS objectForKey:@"token"];
    if (token) {        //判断是否登录
        [self loadAllViewController];
    }else{
        [self loadLoginViewController];
    }
    [self.window makeKeyAndVisible];
    //引导页
    [LaunchIntroductionView sharedWithImages:@[@"refresh1",@"refresh2",@"refresh3",@"refresh4"] buttonImage:@"icon_tab_guangchang_h" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    return YES;
}

//加载所有的视图控制器
-(void)loadAllViewController{
    self.window.rootViewController = [TabViewController new];
}
//加载登录视图控制器
-(void)loadLoginViewController{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"loginViewController" bundle:nil];
    
    UINavigationController * nav = [storyboard  instantiateViewControllerWithIdentifier:@"Login"];
    
    self.window.rootViewController = nav;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
