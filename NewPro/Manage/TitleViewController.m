//
//  TitleViewController.m
//  NewPro
//
//  Created by idea on 2018/4/20.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "TitleViewController.h"
#import "SGPagingView.h"
#import "ManageViewController.h"
#import "Api.h"

@interface TitleViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) NSArray *titleArr;
@end
@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
}


-(void)loadData
{
    Api *api = [[Api alloc]init:self tag:@"getNew"];
    [api getNew];
}

#pragma mark 接口请求出错 ..=1
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    
    NSLog(@"tag:%@  message=%@",tag,message);
    [self setupPageView];
}
#pragma mark 接口请求成功 sucess=0
-(void)Sucess:(id)response tag:(NSString*)tag
{
    if([tag isEqualToString:@"getNew"]){
        
        NSLog(@"@@@@@@!!!!%@",response[@"result"]);
        self.titleArr = response[@"result"];
        [self setupPageView];
    }
}
- (void)setupPageView {
    if (!self.titleArr){
            self.titleArr = @[@"精选", @"电影", @"电视剧", @"综艺", @"NBA", @"娱乐", @"动漫", @"演唱会", @"天天"];
    }
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, KNAVIGATIONANDSTATUSBARHEIGHT, KSCREEN_WIDTH, 44) delegate:self titleNames:_titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isShowIndicator = NO;
    _pageTitleView.isOpenTitleTextZoom = YES;
    NSMutableArray *childArr = [NSMutableArray array];
    for (int i=0; i<_titleArr.count; i++) {
         ManageViewController *vc= [[ManageViewController alloc] init];
        [childArr addObject:vc];
    }
    /// pageContentView
    CGFloat contentViewHeight = KSCREEN_HEIGHT - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), KSCREEN_WIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}



@end
