//
//  SelecterToolsScrolView.m
//  SelecterTools
//
//  Created by zhao on 16/3/15.
//  Copyright © 2016年 xincheng. All rights reserved.
//

#import "SelecterToolsScrolView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define TitleFont 14


@interface SelecterToolsScrolView()

@property(nonatomic,copy)BtnClick btnClick;


@property(nonatomic,retain)NSMutableArray *btnArr;
@property(nonatomic,retain)UIButton * previousBtn;
@property(nonatomic,retain)UIButton * currentBtn;


@property(nonatomic,retain)UIView *bottomScrLine;
@end

@implementation SelecterToolsScrolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithSeleterConditionTitleArr:(NSArray *)titleArr withFrame:(CGRect )frame andBtnBlock:(BtnClick)btnClick
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _btnArr = [NSMutableArray array];
        for (int i = 0; i<titleArr.count; i++) {
            UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*60,0,60,40)];
            titleBtn.tag = i;
            [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:TitleFont];
            [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [titleBtn setTitleColor:RGB(252, 61, 61) forState:UIControlStateSelected];
            [self addSubview:titleBtn];
            [_btnArr addObject:titleBtn];
            if (i == 0) {
                _previousBtn = titleBtn;
                _currentBtn = titleBtn;
                titleBtn.selected = YES;
            }
            
        }
        _bottomScrLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-3,40,2)];
        _bottomScrLine.center = CGPointMake(_currentBtn.center.x, _bottomScrLine.center.y);
        _bottomScrLine.backgroundColor = RGB(252, 61, 61);
        [self addSubview:_bottomScrLine];
        
        self.contentSize = CGSizeMake(titleArr.count*60, 30);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.btnClick = btnClick;
        
    }
    return self;
}


-(void)updateSelecterToolsIndex:(NSInteger )index
{
    UIButton *selectBtn = _btnArr[index];
    [self changeSelectBtn:selectBtn];
}

-(void)btnClick:(UIButton *)sender
{
//    [self changeSelectBtn:sender];
    self.btnClick(sender);
}

-(void)changeSelectBtn:(UIButton *)btn
{
    
    _previousBtn = _currentBtn;
    _currentBtn = btn;
    _previousBtn.selected = NO;
    _currentBtn.selected = YES;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _bottomScrLine.center = CGPointMake(_currentBtn.center.x, _bottomScrLine.center.y);

    } completion:^(BOOL finished) {
        
    }];
    
    
    if (_currentBtn.center.x<WIDTH/2) {
        
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (_currentBtn.center.x > self.contentSize.width-WIDTH/2)
    {
        if (self.contentSize.width <= WIDTH) {
            
        }
        else
        {
        [self setContentOffset:CGPointMake(self.contentSize.width-WIDTH, 0) animated:YES];
        }

    }else
    {
        [self setContentOffset:CGPointMake(btn.center.x-WIDTH/2, 0) animated:YES];
    }
    
}

//
//-(CGFloat)getTitleContentWidth:(NSString *)title
//{
//   CGRect rect = [title boundingRectWithSize:CGSizeMake(WIDTH, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TitleFont]} context:nil];
//    return rect.size.width;
//}



@end
