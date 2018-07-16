//
//  CreatTaskView.m
//  XQKDY
//
//  Created by 张正浩 on 2017/5/13.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "CreatTaskView.h"

@implementation CreatTaskView

- (void)awakeFromNib {
    [super awakeFromNib];
    _confirmBtn.layer.cornerRadius = 20.0f;
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
