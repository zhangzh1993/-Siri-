//
//  JCTagView.m
//  JCLabel
//
//  Created by QB on 16/4/26.
//  Copyright © 2016年 JC. All rights reserved.
//

#import "JCTagView.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f

///随机颜色
#define RandomColor  [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];

@interface JCTagView ()
{
    CGRect _previousFrame;
    int _totalHeight;
    UIButton *_tag;
}
@property (nonatomic, strong) NSMutableArray * titleArr;
@end

@implementation JCTagView

//初始化方法
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _totalHeight = 0;
        self.frame = frame;
    }
    
    return self;
}

//设置 标签数组
- (void)setArrayTagWithLabelArray:(NSArray *)array {
    //设置frame
    _titleArr = [NSMutableArray arrayWithArray:array];
    _previousFrame = CGRectZero;
    [array enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        [self setupBtnWithNSString:str];
    }];
    //    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        [self setupBtnWithNSString:obj];
    //
    //    }];
    ///设置整个View的背景
    if(_JCbackgroundColor){
        
        self.backgroundColor = _JCbackgroundColor;
        NSLog(@"--------%@",_JCbackgroundColor);
    }else{
        self.backgroundColor=[UIColor whiteColor];
    }
    NSLog(@"---+++++-----%@",_JCbackgroundColor);
}


//初始化按钮

- (void)setupBtnWithNSString:(NSString *)str {
    //初始化按钮
    _tag = [UIButton buttonWithType:UIButtonTypeCustom];
    _tag.frame = CGRectZero;
    if (_JCSignalTagColor) {
        _tag.backgroundColor = _JCSignalTagColor;
    }else {
        _tag.backgroundColor = RandomColor;
    }
    //    [_tag setBackgroundImage:[UIImage imageNamed:@"but_colour_selected_"] forState:0];
    //设置内容水平居中
    _tag.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_tag setTitle:str forState:UIControlStateNormal];
    //设置字体的大小
    _tag.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _tag.layer.cornerRadius = 5.0;
    _tag.layer.masksToBounds = YES;
    
//    [_tag.layer setBorderWidth:1.0]; //边框宽度
//    [_tag.layer setBorderColor:kGlobalBg.CGColor];//边框颜色
    //设置字体的颜色
    [_tag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    int x = arc4random() % 5;
    switch (x) {
        case 0:
            [_tag setBackgroundColor:RGB(180, 194, 211)];
            break;
        case 1:
            [_tag setBackgroundColor:RGB(180, 170, 194)];
            break;
        case 2:
            [_tag setBackgroundColor:RGB(202, 195, 187)];
            break;
        case 3:
            [_tag setBackgroundColor:RGB(202, 195, 187)];
            break;
        case 4:
            [_tag setBackgroundColor:RGB(175, 186, 167)];
            break;
        default:
            break;
    }
    
    //设置方法
    [_tag addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    CGSize StrSize = [str sizeWithAttributes:attribute];
    StrSize.width += HORIZONTAL_PADDING * 2;
    StrSize.height += VERTICAL_PADDING *2;
    ///新的 SIZE
    CGRect  NewRect = CGRectZero;
    
    if (_previousFrame.origin.x + _previousFrame.size.width + StrSize.width + LABEL_MARGIN > self.bounds.size.width) {
        
        NewRect.origin = CGPointMake(10, _previousFrame.origin.y + StrSize.height + BOTTOM_MARGIN);
        _totalHeight += StrSize.height + BOTTOM_MARGIN;
    }else {
        NewRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + LABEL_MARGIN, _previousFrame.origin.y);
    }
    NewRect.size = StrSize;
    
    
    if ((_totalHeight + StrSize.height + BOTTOM_MARGIN) > 50) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OpenButtonShow" object:nil];
        if ([_ifOpen intValue] == 1) {
            [_tag setFrame:NewRect];
            _previousFrame = _tag.frame;
            [self setHight:self andHight:_totalHeight + StrSize.height + BOTTOM_MARGIN];
            [self addSubview:_tag];
        }
    }
    else
    {
        [_tag setFrame:NewRect];
        _previousFrame = _tag.frame;
        [self setHight:self andHight:_totalHeight + StrSize.height + BOTTOM_MARGIN];
        
        [self addSubview:_tag];
    }
    ///设置背景 颜色
    
}

#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    NSLog(@"hight:%.2f",hight);
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
//    if (hight > 70) {
//        if ([_ifOpen intValue] == 1) {
//            tempFrame.size.height = hight;
//             NSLog(@"开启:%@",_ifOpen);
//        }
//        else
//        {
//            tempFrame.size.height = 67;
//             NSLog(@"关闭:%@",_ifOpen);
//        }
//    }
    
    view.frame = tempFrame;
}


#pragma mark==========按钮的处理方法

///按钮的处理方法
- (void)clickHandle:(UIButton *)sender{
    NSLog(@"点击了:%@",sender.titleLabel.text);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XuanZeFenLei" object:nil userInfo:@{@"title":sender.titleLabel.text}];
}

@end
