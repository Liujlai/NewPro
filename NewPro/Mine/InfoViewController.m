//
//  InfoViewController.m
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoTableViewCell.h"
#import <JHChainableAnimations/JHChainableAnimator.h>

@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户信息";
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[InfoTableViewCell class] forCellReuseIdentifier:@"Mcell"];
        [self.view addSubview:_tableView];
        _tableView.makeCons(^{
            make.edge.equal.constants(0);
        });
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *ID = @"Mcell";
        InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.title.text = @"头像";
        //        设置1分钟的动画
        JHChainableAnimator *animator = [[JHChainableAnimator alloc] initWithView:cell.icon];
        animator.rotate(3600).animate(60);
        cell.icon.image = [UIImage imageNamed:@"refresh1"];
        return cell;
    }else{
        static NSString *ID = @"cell";
        NSArray *arr = @[@"昵称",@"性别",@"生日"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.textLabel.text = arr[indexPath.row-1];
        cell.detailTextLabel.text = arr[indexPath.row-1];
    return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
