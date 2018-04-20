//
//  ManageViewController.m
//  NewPro
//
//  Created by idea on 2018/4/18.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "ManageViewController.h"
#import "Api.h"
@interface ManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *images = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"refresh1"],
                           [UIImage imageNamed:@"refresh2"],
                           [UIImage imageNamed:@"refresh3"],
                           [UIImage imageNamed:@"refresh4.png"],nil];
    

//    __weak typeof(self) weakSelf = self; --改为-->>> @WeakObj(self);
    @WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfWeak loadNewData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [selfWeak loadNoreData];
    }];
    
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    设置加载时的图片
//    [header setImages:idleImages forState:MJRefreshStateIdle];
//    [header setImages:pullingImages forState:MJRefreshStatePulling];
//    [header setImages:images forState:MJRefreshStateRefreshing];
//    header.stateLabel.hidden = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
    //////    闲置状态
    [header setTitle:@"下拉刷新哦~~" forState:MJRefreshStateIdle];
    //////    松开就可以进行刷新状态
    [header setTitle:@"释放开始刷新哦~~" forState:MJRefreshStatePulling];
    //////    正在刷新中状态
    [header setTitle:@"正在快马加鞭地刷新着呢~~~" forState:MJRefreshStateRefreshing];

    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadData
{
    Api *api = [[Api alloc]init:self tag:@"getNewList"];
    [api getNewList];
}
#pragma mark 接口请求出错 sucess=1
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    
    NSLog(@"tag:%@  message=%@",tag,message);
    
}
#pragma mark 接口请求成功 sucess=0
-(void)Sucess:(id)response tag:(NSString*)tag
{
    if([tag isEqualToString:@"getNewList"]){
        
        NSLog(@"tag:%@  message=%@",tag,response[@"result"][0][@"list"][@"title"]);
        _arr = [NSMutableArray array];
        
        [_arr addObject:response[@"result"][0][@"list"][@"title"]];
        [_arr addObject:response[@"result"][1][@"list"][@"title"]];
    }
    STLog(@"%@",_arr);
}
-(void)loadNewData
{
    NSLog(@"获取最新的数据");
    @WeakObj(self)
    [selfWeak loadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD showSuccess:@"下拉刷新,成功~~"];
        
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
    });
}

-(void)loadNoreData{
    NSLog(@"获取更多数据");
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD showSuccess:@"上拉加载,成功~~"];
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
    
}

-(UITableView *)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.tableFooterView = [UIView new];
//        [_tableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
        _tableView.makeCons(^{
            make.edge.equal.constants(0);
        });
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@",(long)indexPath.row%2==0 ? _arr[0]:_arr[1]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.tableView reloadData];
}
@end
