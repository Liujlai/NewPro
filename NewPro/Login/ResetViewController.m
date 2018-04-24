//
//  ResetViewController.m
//  NewPro
//
//  Created by idea on 2018/4/24.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "ResetViewController.h"
#import "CountDown.h"
@interface ResetViewController ()
@property (strong, nonatomic) IBOutlet UITextField *identifying;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *NormalLayoutConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ShowLayoutConstraint;

@property (strong, nonatomic)  CountDown *countDownForBtn;
@property (nonatomic, strong) UIButton *CodeBtn;
@end

@implementation ResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _countDownForBtn = [[CountDown alloc] init];
    // Do any additional setup after loading the view.
    [self loadViewUI];
}
-(void)loadViewUI
{
    @WeakObj(self);
    self.CodeBtn = Button.str(@"获取验证码")
    .xywh(4,4,100,32)
    .fnt(14)
    .color(AppColor)
    .onClick(^{
        [selfWeak fetchCoder];
    });
    self.identifying.rightView = self.CodeBtn;
    self.identifying.rightViewMode = UITextFieldViewModeAlways;
}
- (IBAction)nextStepBtn:(id)sender {
    self.NormalLayoutConstraint.priority = UILayoutPriorityDefaultLow;
    
    self.ShowLayoutConstraint.priority = UILayoutPriorityDefaultHigh;
    
    
    [UIView animateWithDuration:0.75f animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
}

-(void)fetchCoder{
    STLog(@"~@@@@@@@@@fjdskfdlsf")
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    //    1个小时的倒计时
    //    NSTimeInterval anHour = 60*60;
    //     1天的倒计时
    //    NSTimeInterval aDay = 24*60*60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes]];
}

//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate{
    @WeakObj(self);
    [_countDownForBtn countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSecond==0) {
            selfWeak.CodeBtn.enabled = YES;
            selfWeak.CodeBtn.str(@"重新获取验证码");
        }else{
            selfWeak.CodeBtn.enabled = NO;
            selfWeak.CodeBtn.str(@"%lis后重新获取",totoalSecond);
        }
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_countDownForBtn destoryTimer];
    NSLog(@"%s dealloc",object_getClassName(self));
}
@end
