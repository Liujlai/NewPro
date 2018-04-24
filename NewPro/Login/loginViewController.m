//
//  loginViewController.m
//  NewPro
//
//  Created by idea on 2018/4/21.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "loginViewController.h"
@interface loginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *logoImg;
@property (strong, nonatomic) IBOutlet UITextField *nameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextfield;
@property (strong, nonatomic) IBOutlet UIImageView *loginBg;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *NormalLayoutConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ShowLayoutConstraint;


@property (nonatomic, strong) UIImageView *pwdRightImg;
@end
#pragma mark - 登录界面
@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建打开键盘的收起与打开的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardwillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardwillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self loadViewUI];
    // Do any additional setup after loading the view.
}

- (IBAction)loginbtn:(id)sender {
    [self.view endEditing:YES];
    
    NSString *userName = self.nameTextfield.text;
    NSString *password = self.pwdTextfield.text;
    
    [self login:userName password:password];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)login:(NSString *)userName password:(NSString *)password{
    if ([self validateUserName:userName userPwd:password]) {
//        if ([userName isEqualToString:@"zzz"]) {
            [self loginSuccess:@"ssss" userId:nil];
//        }
    }
}
- (void)loginSuccess:(NSString *)token userId:(NSString *)userId{
    [HUD showSuccess:@"登录成功"];
    //存token
    [DEFAULTS setObject:token forKey:@"token"];
    [DEFAULTS setObject:userId forKey:@"userId"];
    //调界面
    [(AppDelegate *)ShareApplicationDelegate loadAllViewController];
}
//验证用户信息格式
- (BOOL)validateUserName:(NSString*)userName
                 userPwd:(NSString*)userPwd{
    if (userName.length == 0) {
        
        [HUD showError:@"用户名不能为空!"];
        
        [self.nameTextfield becomeFirstResponder];
        
        return NO;
        
    }
    else if (userPwd.length == 0) {
        [HUD showError:@"密码不能为空!"];
        
        [self.pwdTextfield becomeFirstResponder];
        
        return NO;
    }
    
    return YES;
}

-(void)loadViewUI
{
    self.nameTextfield.leftView = ImageView.img(@"userImg").xywh(4,4,32,32);
    self.nameTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.pwdTextfield.leftView = ImageView.img(@"pwdImg").xywh(4,4,32,32);
    self.pwdTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.pwdRightImg = ImageView.img(@"icon_tab_guangchang").onClick(@"setupPwd:");
    self.pwdRightImg.tag = 1;
    self.pwdTextfield.rightView = self.pwdRightImg;
  
    self.pwdTextfield.rightViewMode = UITextFieldViewModeWhileEditing;
    self.loginBg.img(@"loginBG");
    self.logoImg.borderRadius(20);
    [self setupAnimator];
    
}
//切换密码框是否显示明文
-(void)setupPwd:(UIImageView*)serder
{
    if (self.pwdRightImg.tag == 1) {
        self.pwdTextfield.rightView = self.pwdRightImg.img(@"icon_tab_guangchang_h");
        [self.pwdTextfield setSecureTextEntry:NO];
        self.pwdRightImg.tag = 0;
    }else{
        self.pwdTextfield.rightView = self.pwdRightImg.img(@"icon_tab_guangchang");
        [self.pwdTextfield setSecureTextEntry:YES];
        self.pwdRightImg.tag = 1;
    }
}


-(void)setupAnimator
{
    JHChainableAnimator *logoAnimator = [[JHChainableAnimator alloc] initWithView:self.logoImg];
    logoAnimator.rotate(1800).animate(20.0);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self.view endEditing:YES];
}


//输入密码或者用户名时键盘的收起与打开
// 显示键盘
- (void)keyBoardwillShow:(NSNotification *)notification{
    
    self.NormalLayoutConstraint.priority = UILayoutPriorityDefaultLow;
    
    self.ShowLayoutConstraint.priority = UILayoutPriorityDefaultHigh;
    
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
}
// 关闭键盘
- (void)keyBoardwillHide:(NSNotification *)notification{
    
    self.NormalLayoutConstraint.priority = UILayoutPriorityDefaultHigh;
    
    self.ShowLayoutConstraint.priority = UILayoutPriorityDefaultLow;
    
    
    //    添加一个动画，避免生硬的效果
    [UIView animateWithDuration:0.25f animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
