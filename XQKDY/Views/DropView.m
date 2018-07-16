//
//  DropView.m
//  XQKDY
//
//  Created by 张正浩 on 2017/5/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "DropView.h"

@implementation DropView

- (void)awakeFromNib {
    [super awakeFromNib];
    _confirmBtn.layer.cornerRadius = 5.0f;
    _sendImageView.layer.cornerRadius = 5.0f;
    _recentImageView.layer.cornerRadius = 5.0f;
    _categoryImageView.layer.cornerRadius = 5.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
