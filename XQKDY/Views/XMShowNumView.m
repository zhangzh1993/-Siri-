//
//  XMShowNumView.m
//  Efetion
//
//  Created by zyh on 16/6/14.
//
//

#import "XMShowNumView.h"
#import "Masonry.h"

@implementation XMShowNumView
- (instancetype)init{
    if (self = [super init]) {
       [self initialized];
    }
    return self;
}

- (void)initialized{
    self.backgroundColor = [UIColor whiteColor];
    UILongPressGestureRecognizer *Press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyLongPress:)];
    [self addGestureRecognizer:Press];
    [self addSubview:self.inputNumberLabel];
    [self addSubview:self.delBtn];
}
-(UILabel *)inputNumberLabel{
    if (!_inputNumberLabel) {
        _inputNumberLabel = [[UILabel alloc]init];
        _inputNumberLabel.text = @"";
        _inputNumberLabel.userInteractionEnabled = YES;
        _inputNumberLabel.textColor = [UIColor grayColor];
        _inputNumberLabel.font = [UIFont systemFontOfSize:27];
        _inputNumberLabel.adjustsFontSizeToFitWidth = YES;
       }
    return _inputNumberLabel;
}

-(UIButton *)delBtn{
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delBtn.hidden = YES;
        [_delBtn setImage:[UIImage imageNamed:@"icon_close_4"] forState:UIControlStateNormal];
       //逐个删除
        [_delBtn addTarget:self action:@selector(deleteOneByOne) forControlEvents:UIControlEventTouchUpInside];
        //长按全部删除
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAll:)];
        [_delBtn addGestureRecognizer:longPress];
    }
    return _delBtn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
     [self.inputNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self).with.offset(60);
         make.top.equalTo(self);
         make.height.equalTo(self);
         make.right.equalTo(self).with.offset(-80);
     }];
     [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(30, 30));
         make.right.equalTo(self).with.offset(-25);
         make.centerY.equalTo(self);
     }];
}
-(void)deleteOneByOne{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteOneByOne)]) {
        [self.delegate deleteOneByOne];
    }
}
-(void)deleteAll:(UIGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan){
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAll)]) {
            [self.delegate deleteAll];
        }
    }
}
-(void)copyLongPress:(UILongPressGestureRecognizer*)recognizer{
       [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.bounds inView:self];
         [menu setMenuVisible:YES animated:YES];
    
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{

    return [super canPerformAction:action withSender:sender];
}
-(void)cut:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.inputNumberLabel.text;
    self.inputNumberLabel.text = @"";
}
-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.inputNumberLabel.text;
}
@end
