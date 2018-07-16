//
//  SelecterContentScrollView.m
//  SelecterTools
//
//  Created by zhao on 16/3/15.
//  Copyright © 2016年 xincheng. All rights reserved.
//

#import "SelecterContentScrollView.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface SelecterContentScrollView ()<UIScrollViewDelegate>

@property(nonatomic,retain)NSArray *vcArr;
@property(nonatomic,copy)ScrollPage scrollPage;


@end

@implementation SelecterContentScrollView



-(instancetype)initWithSeleterConditionTitleArr:(NSArray *)vcArr withFrame:(CGRect)frame andBtnBlock:(ScrollPage)page
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _vcArr = vcArr;
        [self lazyLoadVcFromIndex:0];
        self.pagingEnabled = YES;
        
        self.contentSize = CGSizeMake(WIDTH * vcArr.count,self.frame.size.height);
        
        self.delegate = self;
        self.scrollPage = page;

    }
    return self;
}



-(void)updateVCViewFromIndex:(NSInteger )index
{
//    [self lazyLoadVcFromIndex:index];
    [self setContentOffset:CGPointMake(index*WIDTH, 0) animated:YES];
}

//懒加载策略
-(void)lazyLoadVcFromIndex:(NSInteger )index
{
    UIViewController *vc = _vcArr[index];
    vc.view.frame = CGRectMake(WIDTH*index,0, WIDTH,self.frame.size.height);
    [self addSubview:vc.view];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x+WIDTH/2)/WIDTH;
    [self lazyLoadVcFromIndex:page];
    self.scrollPage(page);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
