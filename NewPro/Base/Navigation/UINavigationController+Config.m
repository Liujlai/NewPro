//
//  UINavigationController+Config.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "UINavigationController+Config.h"

@implementation UINavigationController (Config)

-(void)configNavBarColor{
    
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:33/255. green:190/255. blue:217/255. alpha:1.0]];// 显示颜色是：0x21bed9 即 DOCTOR_COLOR_BLUE
    [self.navigationBar  setTintColor:[UIColor whiteColor]];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

@end
