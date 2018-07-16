//
//  SendStoreCell.m
//  MaoWu
//
//  Created by 张正浩 on 16/8/4.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "SendStoreCell.h"

@implementation SendStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - setData
- (void)setData:(IncomeDetailModel *)data{
    if (data) {
        _data=data;
        [self loadViewData];
    }
}
- (void)loadViewData{
    
    _storeNameLab.text = [NSString stringWithFormat:@"%@",_data.title];
    
    //    _amountLab.text = [NSString stringWithFormat:@"%@",_data.amount];
    //    if ([_data.title isEqualToString:@"单价"]) {
    if ([_data.price isEqualToString:@"out"]) {
        _amountLab.text = [NSString stringWithFormat:@"-¥ %.2f",[_data.amount floatValue]/100];
    
    }
    else
    {
        _amountLab.text = [NSString stringWithFormat:@"+¥ %.2f",[_data.amount floatValue]/100];
        _amountLab.textColor = RGB(237, 94, 94);
    }
    
    //    }
    
    
}
@end
