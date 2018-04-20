//
//  TabViewController.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "TabViewController.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "TitleViewController.h"
#import "MineViewController.h"
#import "UINavigationController+Config.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //首页
    HomeViewController *vc = [HomeViewController new];
    [self addChildViewController:vc imageName:@"icon_tab_guangchang" title:@"首页"];
    //管理
    TitleViewController *vc1 = [TitleViewController new];
    [self addChildViewController:vc1 imageName:@"icon_tab_guanli" title:@"管理"];
    //我的
    MineViewController *vc2 = [MineViewController new];
    [self addChildViewController:vc2 imageName:@"icon_tab_wo" title:@"我的"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///添加子控制器,设置标题与图片
- (void)addChildViewController:(UIViewController *)childCtrl imageName:(NSString *)imageName title:(NSString *)title{
    
    //设置选中与未选中的图片-->指定一下渲染模式-->图片以原样的方式显示出来
    childCtrl.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_h",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题
    childCtrl.title = title;
    
    //指定一下属性
    NSDictionary *normalAttrDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil];
    [childCtrl.tabBarItem setTitleTextAttributes:normalAttrDict forState:UIControlStateNormal];
    
    UIColor *textColor = [UIColor colorWithRed:(68./255.) green:(181./255.) blue:(233./255.) alpha:1.];
    NSDictionary *selectedAttrDict = [NSDictionary dictionaryWithObjectsAndKeys:textColor, NSForegroundColorAttributeName, nil];
    [childCtrl.tabBarItem setTitleTextAttributes:selectedAttrDict forState:UIControlStateSelected];
    
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:childCtrl];
    [navCtrl configNavBarColor];
    [self addChildViewController:navCtrl];
}

@end
