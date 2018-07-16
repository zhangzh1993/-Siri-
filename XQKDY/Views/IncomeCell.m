//
//  IncomeCell.m
//  MaoWu
//
//  Created by 张正浩 on 16/4/27.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "IncomeCell.h"

@implementation IncomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - setData
- (void)setData:(IncomeDateModel *)data{
    if (data) {
        _data=data;
        [self loadViewData];
    }
}
- (void)loadViewData{
    _dateLab.text = [NSString stringWithFormat:@"%@",_data.date];
    _moneyLab.text = [NSString stringWithFormat:@"¥ %.2f",[_data.money floatValue]/100];

    
}
@end
