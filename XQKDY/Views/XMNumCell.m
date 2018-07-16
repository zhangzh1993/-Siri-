//
//  XMNumCell.m
//  拨号盘
//
//  Created by zyh on 16/6/12.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import "XMNumCell.h"
@implementation XMNumCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    self.numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numberBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.numberBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.numberBtn.frame = CGRectMake(0,0,62 KSCALE,62 KSCALE);
}
-(void)setData:(XMNumData *)data{
    if (_data != data) {
        _data = data;
    }
    [self.numberBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",data.normal]] forState:UIControlStateNormal];
}
-(void)handleAction:(UIButton *)sender{
    self.numBlock();
}
@end
