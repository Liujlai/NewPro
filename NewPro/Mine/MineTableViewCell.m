//
//  MineTableViewCell.m
//  NewPro
//
//  Created by idea on 2018/4/19.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell


-(UIImageView *)icon
{
    if (_icon == nil) {
        _icon = [[UIImageView alloc]init];
        _icon.borderRadius(30);
        [self.contentView addSubview:_icon];
        _icon.makeCons(^{
            make.left.equal.constants(40);
            make.centerY.equal.view(self);
            make.width.height.equal.constants(60);
        });
    }
    return _icon;
}

- (UILabel *)title
{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        _title.makeCons(^{
            make.top.constants(20);
            make.left.equal.view(self.icon).right.constants(20);
            make.right.constants(-30);
        });
    }
    return _title;
    
}

- (UILabel *)content
{
    if (_content == nil) {
        _content = [[UILabel alloc]init];
        [self.contentView addSubview:_content];
        _content.makeCons(^{
            make.top.equal.view(self.title).bottom.constants(10);
            make.left.equal.view(self.title);
            make.right.constants(-30);
            make.bottom.equal.constants(-20);
        });
    }
    return _content;
}


@end
