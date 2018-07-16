//
//  TCAlertView.m
//  TCAlertView
//
//  Created by Arthur on 2017/3/23.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import "TCAlertView.h"
#import "UIView+Frame.h"
@interface TCAlertView()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation TCAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
    

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text =  @"新增柜子";
    [self addSubview:titleLabel];

    UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.bottom + 10, 0, 36)];
    remarkLabel.textAlignment = NSTextAlignmentLeft;
    remarkLabel.font = [UIFont systemFontOfSize:16];
    remarkLabel.text = @"备注";
    [self addSubview:remarkLabel];
    
    self.remarkField = [[UITextField alloc] initWithFrame:CGRectMake(remarkLabel.right + 10, remarkLabel.top, self.width - 30 - remarkLabel.width, 34)];
    self.remarkField.font = [UIFont systemFontOfSize:16];
    self.remarkField.layer.masksToBounds = YES;
    self.remarkField.layer.cornerRadius = 4;
    self.remarkField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.remarkField.layer.borderWidth = 0.8;
    self.remarkField.placeholder = @"请输入柜子名称";
    [self addSubview:self.remarkField];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, remarkLabel.bottom + 20, 0, 36)];
    msgLabel.text = @"附加信息";
    msgLabel.font = [UIFont systemFontOfSize:16];
    msgLabel.textAlignment  = NSTextAlignmentLeft;
    [self addSubview:msgLabel];
    
    
    self.msgField = [[UITextField alloc] initWithFrame:CGRectMake(msgLabel.right + 10, msgLabel.top, self.width-msgLabel.width-30, 34)];
    self.msgField.font = [UIFont systemFontOfSize:16];
    self.msgField.layer.masksToBounds = YES;
    self.msgField.layer.cornerRadius = 4;
    self.msgField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.msgField.layer.borderWidth = 0.8;
    self.msgField.placeholder = @"请输入柜子地址";
    [self addSubview:self.msgField];

    
    UIButton *pButton = [UIButton buttonWithType:UIButtonTypeSystem];
    pButton.frame = CGRectMake(self.width - 50, self.height - 40, 40, 32);
    [pButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pButton setTitle:@"确定" forState:UIControlStateNormal];
    [pButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pButton];
    
    
    UIButton *qButton = [UIButton buttonWithType:UIButtonTypeSystem];
    qButton.frame = CGRectMake(self.width - 120, pButton.top, 40, 32);
    [qButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [qButton setTitle:@"取消" forState:UIControlStateNormal];
    [qButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:qButton];

}

#pragma mark --展示view
- (void)showView {
    
    _remarkField.text = @"";
    _msgField.text = @"";
    
    if (self.bgView) {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha =  0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
}

- (void)tap:(UIGestureRecognizer *)gr {
    
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}

#pragma mark --关闭view
- (void)closeView {
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}


- (void)cancelAction:(UIButton *)button {
    [self closeView];
}


- (void)sendAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(requestEventAction:)]) {
        [self.delegate requestEventAction:button];
    }
}




@end
