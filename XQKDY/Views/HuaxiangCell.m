//
//  HuaxiangCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/4/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "HuaxiangCell.h"

@implementation HuaxiangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _zhunshiLabel.layer.cornerRadius = 3.0f;
    _zhundianLabel.layer.cornerRadius = 3.0f;
    // Initialization code
}
-(void)setData:(FollowerModel *)data
{
    _titleLabel.text = data.nickname;
    _dateLabel.text = data.date;
    _zhunshiLabel.textColor = RGB(100, 100, 100);
    _zhunshiLabel.backgroundColor = RGB(227, 227, 227);
    _zhundianLabel.textColor = RGB(100, 100, 100);
    _zhundianLabel.backgroundColor = RGB(227, 227, 227);
     _tousuLabel.text = @"";
    if (data.time.length > 0) {
        _zhunshiLabel.textColor = kGlobalBg;
        _zhunshiLabel.backgroundColor = RGB(253, 240, 232);
    }
    if (data.place.length > 0) {
        _zhundianLabel.textColor = RGB(115, 179, 255);
        _zhundianLabel.backgroundColor = RGB(245, 245, 245);
    }
    _zhunshiLabel.text = data.time.length > 0? data.time:@"准时";
    _zhundianLabel.text = data.place.length > 0? data.place:@"准点";
    
    if ([data.complainTimes integerValue] > 0) {
        _tousuLabel.text = [NSString stringWithFormat:@"投诉 %@次",data.complainTimes];
        [_tousuLabel setHidden:NO];
    }
    else{
        [_tousuLabel setHidden:YES];
    }
    _timeWidth.constant = [self getWidthWithTitle:_zhunshiLabel.text font:[UIFont systemFontOfSize:12]] + 10;
    _placeWidth.constant = [self getWidthWithTitle:_zhundianLabel.text font:[UIFont systemFontOfSize:12]]+ 10;
    _tousuWidth.constant = [self getWidthWithTitle:_tousuLabel.text font:[UIFont systemFontOfSize:12]]+ 10;

}
-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
