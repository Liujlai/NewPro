//
//  InfoViewController.h
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *brith;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UITextField *nick;
@end
