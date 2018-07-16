//
//  ZJSwipeButton.m
//  ZJSwipTableView
//
//  Created by ZeroJ on 16/10/13.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJSwipeButton.h"

@interface ZJSwipeButton ()
@property (copy, nonatomic) ZJSwipeButtonOnClickHandler onClickHandler;
@end
@implementation ZJSwipeButton

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image onClickHandler:(ZJSwipeButtonOnClickHandler)onClickHandler {
    if (self = [super init]) {
        _onClickHandler = [onClickHandler copy];
        [self addTarget:self action:@selector(swipeBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.backgroundColor = [UIColor whiteColor];
        CGFloat margin = 10;
        // 计算文字尺寸
        CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 200.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font, NSForegroundColorAttributeName: self.titleLabel.textColor } context:nil].size;
        // 计算按钮宽度, 取图片宽度和文字宽度较大者
        
        CGFloat btnWidth = image.size.width* 90/image.size.height+margin;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 暂时的, 宽高有效, 其他的会在父控件(ZJSwipeView)中调整
        self.frame = CGRectMake(0.f, 0.f, btnWidth + 50, 150);

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageView.image) {
        // 设置了图片, 重新调整imageView和titleLabel的frame
        // 让图片在上, 文字在下显示
        CGFloat selfHeight = self.bounds.size.height;
        CGFloat selfWidth = self.bounds.size.width;

        CGSize imageSize = self.imageView.image.size;
        CGFloat imageAndTextMargin = 5.f;

        CGFloat margin = (selfHeight - imageSize.height - self.titleLabel.bounds.size.height - imageAndTextMargin)/2;
        self.imageView.frame = CGRectMake(30, 20, self.imageView.image.size.width* 90/self.imageView.image.size.height, 90);
        // 计算文本frame
        CGRect titleLabelFrame = self.titleLabel.frame;
        titleLabelFrame.origin.x = 0;
        titleLabelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) ;
        titleLabelFrame.size.width = selfWidth;
        titleLabelFrame.size.height = 20;
        self.titleLabel.frame = titleLabelFrame;
    }
}
// 按钮点击响应事件
- (void)swipeBtnOnClick:(UIButton *)btn {
    if (_onClickHandler) {
        _onClickHandler(btn);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RightSwipeOver" object:nil];
    }
}


@end
