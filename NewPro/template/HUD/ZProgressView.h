//
//  ViewController.m
//  BaseVC
//
//  Created by idea on 2018/4/16.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS (NSInteger ,ZProgressHUDType)
{
    ZProgressHUDTypeLoading = 0,
    ZProgressHUDTypeSuccess = 1,
    ZProgressHUDTypeError   = 2,
    ZProgressHUDTypeMessage = 3
};
@interface ZProgressView : UIView
@property (nonatomic,strong) NSString *message;
@property (nonatomic,assign) ZProgressHUDType hudViewType;
- (instancetype)init;
- (void)hudShowWithType:(ZProgressHUDType)hudViewType message:(NSString *)message;
- (void)show;
- (void)dismiss;
@end
