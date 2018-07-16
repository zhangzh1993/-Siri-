//
//  RecordCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/5/3.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.layer.cornerRadius = 15.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
