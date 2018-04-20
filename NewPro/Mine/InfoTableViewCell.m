//
//  InfoTableViewCell.m
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (UILabel *)title
{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        _title.makeCons(^{
            make.top.constants(30);
            make.left.constants(20);
            make.centerY.equal.view(self.contentView);
        });
    }
    return _title;
    
}

-(UIImageView *)icon
{
    if (_icon == nil) {
        _icon = [[UIImageView alloc]init];
        _icon.borderRadius(25);
        [self.contentView addSubview:_icon];
        _icon.makeCons(^{
            make.right.equal.constants(-20);
            make.width.height.constants(50);
            make.centerY.view(self.contentView);
        });
    }
    return _icon;
}


@end
