//
//  InfoViewController.m
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoTableViewCell.h"
#import <BRPickerView.h> //选生日。时间。...
#import "SelectPhotoManager.h" //选头像

@interface InfoViewController ()

@property (nonatomic, strong)SelectPhotoManager *photoManager;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户信息";
    UIImage *img = [UIImage imageWithData:[DEFAULTS objectForKey:@"headerImage"]];
    if (img) {
        self.userIcon.image = img;
        
    }
    self.nick = TextField;
    [self setupTable];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)setupTable{
    NSArray *arr = @[@"头像",@"昵称",@"性别",@"生日"];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]; //删除视图
    PlainTV(
            Row.str(arr[0]).custom(^(id contentView){
                self.userIcon = ImageView.img(@"userIcon").fixWH(60,60).embedIn(contentView,10,NERNull,10,40);
                JHChainableAnimator *animator = [[JHChainableAnimator alloc] initWithView:self.userIcon];
                animator.rotate(3600).animate(60);
        
            }).cellHeightAuto.disclosure.onClick(@"setPhoto"),
            Row.str(arr[1]).custom(^(id contentView){
                self.nick.hint(self.nickName ? self.nickName:@"输入昵称(≥15字)").maxLength(15).rightAlignment.embedIn(contentView,10,NERNull,10,40);
                self.nickName = self.nick.text;
            }).disclosure,
            Row.str(arr[2]).detailStr(self.sex).disclosure.onClick(@"setSEX"),
            Row.str(arr[3]).detailStr(self.brith).disclosure.onClick(@"DatePicker")
            ).embedIn(self.view);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPhoto{
    
    if (!_photoManager) {
        _photoManager =[[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:@"选择头像"];
     @WeakObj(self);
    //选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
        
        selfWeak.userIcon.image = image;
        //保存到本地
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
    };
}

//设置性别
- (void)setSEX
{
    ActionSheet.title(@"选择性别").destructiveAction(@"男", ^{
        self.sex = @"男";
        [self setupTable];
    }).action(@"女", ^{
        self.sex = @"女";
        [self setupTable];
    }).cancelAction(@"取消").show();
    
}
//选择生日
-(void)DatePicker{
    NSDate *minDate = [NSDate setYear:1970 month:3 day:3];
    NSDate *maxDate = [NSDate date];
    @WeakObj(self);
    [BRDatePickerView showDatePickerWithTitle:@"出生日期" dateType:BRDatePickerModeYMD defaultSelValue:selfWeak.brith minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        selfWeak.brith = selectValue;
       [self setupTable];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}



@end
