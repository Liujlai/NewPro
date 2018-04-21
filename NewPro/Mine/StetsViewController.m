//
//  StetsViewController.m
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "StetsViewController.h"

@interface StetsViewController ()

@end
#pragma mark - 清楚缓存
@implementation StetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)setupUI
{
    self.str = [self strSize];
    @WeakObj(self);
    GroupTV(
            Row.str(@"意见反馈").disclosure,
            Section(Row.str(@"版本更新").disclosure.onClick(^{
                [selfWeak versionUpdates];
            }),
                    Row.str(@"清除缓存").detailStr(self.str).disclosure.onClick(^{
                [selfWeak cleanCaches];
                
            })
                    ),
            Section(
                    Row.custom(^(id contentView) {
                Label.str(@"退出登录").color(AppColor).centerAlignment.embedIn(contentView);
            }).onClick(^{
                [DEFAULTS removeObjectForKey :@"token"];
                //调界面
                [(AppDelegate *)ShareApplicationDelegate loadLoginViewController];
            })
                    )
            ).embedIn(self.view);
}
-(void)versionUpdates
{
    Alert.title(@"发现新版本：V1.222").message(@"建议在Wi-Fi条件下更新\n 更新内容： \n修复了bug～").action(@"下次再说", ^{
        
    }).action(@"立即升级", ^{
        [HUD showSuccess:@"升级成功，已是最新版本~~~"];
    }).show();
}

#pragma mark - 返回缓存大小
-(NSString *)strSize{
    NSString *cachepath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *str = [NSString stringWithFormat:@"%.2fM", [self folderSizeAtPath:cachepath]];
    return str;
}

/**
 清除缓存
 */
-(void)cleanCaches
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            NSFileManager *manager = [NSFileManager defaultManager];
            NSArray *files = [manager subpathsAtPath:cachePath];
            for (NSString *p in files) {
                NSError *error = nil;
                NSString *path = [cachePath stringByAppendingPathComponent:p];
                if ([manager fileExistsAtPath:path]) {
                    [manager removeItemAtPath:path error:&error];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupUI];
            });
        });
        
        [HUD showSuccess:@"清理成功"];
        
    }];
    [ac addAction:cancelAction];
    [ac addAction:ensureAction];
    [self presentViewController:ac animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 遍历文件夹获得文件夹大小，返回多少M */
- (float )folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}



@end
