//
//  HomeViewController.m
//  LNetwork
//
//  Created by idea on 2018/4/11.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "Api.h"
#import "LHeader.h"
#pragma mark - 轮播图
@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSArray *imagesURLStrings = @[
                                  @"http://placeimg.com/414/180/tech/sepia",
                                  @"http://placeimg.com/414/180/nature/sepia",
                                  @"http://placeimg.com/414/180/people/sepia",
                                  @"http://placeimg.com/414/180/animals/sepia",
                                  @"http://placeimg.com/414/180/architecture"
                                  ];
    
    NSArray *titles = @[@"👨🏻‍🏭世俗",
                        @"🤧义分",
                        @"🎃义分义分义分",
                        @"😼",
                        @"👏🏻"
                        ];
    
//    上下滚动的轮播图
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -370, KSCREEN_WIDTH, 180) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings];
//    cycleScrollView.delegate = self;
//    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
//    [self.table addSubview:cycleScrollView];
//    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
//    左右滚动的轮播图
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -180, KSCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.table addSubview:cycleScrollView2];
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;

    self.table.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
}
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              0,
                                                              KSCREEN_WIDTH,
                                                              KSCREEN_HEIGHT-KNAVIGATIONANDSTATUSBARHEIGHT
                                                              ) style:(UITableViewStylePlain)];
        _table.delegate = self;
        _table.dataSource  = self;
        _table.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_table];
        
        _table.mj_header = [LHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD showSuccess:@"刷新成功"];
            });
            [self->_table.mj_header endRefreshing];
        }];
        

        _table.mj_footer  = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [HUD showSuccess:@"加载成功"];
            });
            [self->_table.mj_footer endRefreshing];
        }];
    }
    return _table;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [HUD showLoading:@"页面疯狂加载中>>>"];
    Api * api1 =[[Api alloc] init:self tag:@"gethello"];
    [api1 gethello];
//    Api *api2 = [[Api alloc]init:self tag:@"login"];
//    [api2 login:@"咋粉丝" password:@"18"];

}
-(void)api
{
    Api *api2 = [[Api alloc]init:self tag:@"login"];
    [api2 login:@"咋粉丝" password:@"18"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 接口请求出错 sucess=1
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    
    NSLog(@"tag:%@  message=%@",tag,message);
    
}
#pragma mark 接口请求成功 sucess=0
-(void)Sucess:(id)response tag:(NSString*)tag
{
    if([tag isEqualToString:@"getList"]){
        
        NSLog(@"@@@@@@!!!!%@",response);
    }
    else if ([tag isEqualToString:@"gethello"]){
        
        NSLog(@"@#########!%@",response);
        NSString *str = [NSString stringWithFormat:@"%@", response];
         [HUD showSuccess:str];
    }else{
        NSString *str = [NSString stringWithFormat:@"%@", response];
        [HUD showSuccess:str];
    }
}

@end
