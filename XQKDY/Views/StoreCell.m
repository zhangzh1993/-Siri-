//
//  StoreCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/4/11.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //关键语句
    
    _closeBtn.layer.cornerRadius = 3.0;//2.0是圆角的弧度，根据需求自己更改
    _closeBtn.layer.borderColor = kGlobalBg.CGColor;//设置边框颜色
    _closeBtn.layer.borderWidth = 1.0f;//设置边框颜色
    
    _editBtn.layer.cornerRadius = 3.0;//2.0是圆角的弧度，根据需求自己更改
    _editBtn.layer.borderColor = kGlobalBg.CGColor;//设置边框颜色
    _editBtn.layer.borderWidth = 1.0f;//设置边框颜色
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
