//
//  ViewController.m
//  NewPro
//
//  Created by idea on 2018/4/17.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "ViewController.h"
#import "HUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HUD showLoading:@"页面疯狂加载中>>>"];
    self.view.backgroundColor = [UIColor cyanColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [HUD showError:@"其实并没有UI"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BOOL)iPhoneX
{
    static BOOL b;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        b = CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size);
    });
    return b;
}
@end
