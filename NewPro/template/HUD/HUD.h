//
//  ViewController.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUD : NSObject

+(void)showSuccess :(NSString*)status;
+(void)showError :(NSString*)status;
+(void)showLoading :(NSString*)status;
+(void)showInfo :(NSString*)status;
+(void)dismiss;
@end
