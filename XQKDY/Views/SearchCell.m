//
//  SearchCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/4/14.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _confirmBtn.layer.cornerRadius = 5.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
