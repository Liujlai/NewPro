//
//  MineViewController.m
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "InfoViewController.h"
#import "StetsViewController.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfWeak loadNewData];
    }];

}

-(void)loadNewData
{
    NSLog(@"获取最新的数据");
    @WeakObj(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD showSuccess:@"下拉刷新,成功~~"];
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 10;
        _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        _tableView.tableFooterView = [UIView new]; //去除tableView底部多余的线
        [_tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"Minecell"];
        [self.view addSubview:_tableView];
        _tableView.makeCons(^{
            make.edge.equal.constants(0);
        });
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 3;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        static NSString *ID = @"Minecell";
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
//        设置1分钟的动画
        JHChainableAnimator *animator = [[JHChainableAnimator alloc] initWithView:cell.icon];
        animator.rotate(3600).animate(60);
        cell.icon.image = [UIImage imageNamed:@"refresh1"];
        cell.title.text = @"张三";
        cell.content.text = @"1333333##33";
        return cell;
    }else{
        static NSString *ID = @"cell";
        NSArray *arr = @[@"我的余额",@"我的账单",@"身份认证",@"邀请有礼",@"设置"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault; //设置cell选中是的颜色
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.imageView.image = [UIImage imageNamed:@"icon_tab_guangchang_h"];
        cell.textLabel.text = arr[indexPath.section==1 ? indexPath.row:indexPath.row+3];
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 2 && indexPath.row ==1) {
        StetsViewController *vc = [[StetsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        InfoViewController *vc = [[InfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
