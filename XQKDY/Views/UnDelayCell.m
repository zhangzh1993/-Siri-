//
//  UnDelayCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/5/3.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "UnDelayCell.h"

@implementation UnDelayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _resendBtn.layer.cornerRadius = 4.0;//2.0是圆角的弧度，根据需求自己更改
    _resendBtn.layer.borderColor = kGlobalBg.CGColor;//设置边框颜色
    _resendBtn.layer.borderWidth = 1.0f;//设置边框颜色

     _confirmBtn.layer.cornerRadius = 4.0;//2.0是圆角的弧度，根据需求自己更改
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
