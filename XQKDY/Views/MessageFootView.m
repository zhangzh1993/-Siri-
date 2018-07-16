//
//  MessageFootView.m
//  ZhuanTiKu_GWY
//
//  Created by yangyu on 16/7/12.
//  Copyright © 2016年 youbinbin. All rights reserved.
//

#import "MessageFootView.h"
#import "UIColor+zhangshujia.h"

@interface MessageFootView()

@property(nonatomic, strong) UIButton *deleteBtn;
@property(nonatomic, strong) UIView *lineView;
@end
@implementation MessageFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithBottomBtn];
    }
    return self;
}

- (void)initWithBottomBtn {
    //全选
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"icon_select_default_"] forState:0];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"icon_select_selected_"] forState:UIControlStateSelected];
    self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.selectAllBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.selectAllBtn.frame = CGRectMake(0, 0, kScreenWidth / 3 , self.frame.size.height);
    [self.selectAllBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectAllBtn];

    UILabel * hejiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.selectAllBtn.right, 15, 50, 20)];
    hejiLabel.text = @"合计:";
    hejiLabel.textColor = RGB(51, 51, 51);
    hejiLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:hejiLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(hejiLabel.right, 15, 40, 20)];
    _countLabel.text = @"0";
    _countLabel.textColor = kGlobalBg;
    _countLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_countLabel];
    
    UILabel * jianLabel = [[UILabel alloc] initWithFrame:CGRectMake(_countLabel.right, 15, 50, 20)];
    jianLabel.text = @"件";
    jianLabel.textColor = RGB(51, 51, 51);
    jianLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:jianLabel];
    
    
    //删除
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.deleteBtn setBackgroundColor:kGlobalBg];
    self.deleteBtn.frame = CGRectMake(jianLabel.right, 0, kScreenWidth - jianLabel.right, self.frame.size.height);
    [self.deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}

- (void)selectBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(messageFootViewSelectBtn:)]) {
        [_delegate messageFootViewSelectBtn:sender];
    }
}

- (void)deleteBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(messageFootViewDeleteBtn:)]) {
        [_delegate messageFootViewDeleteBtn:sender];
    }
}
@end
