//
//  SelecterToolsScrolView.h
//  SelecterTools
//
//  Created by zhao on 16/3/15.
//  Copyright © 2016年 xincheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BtnClick)(UIButton *);


typedef enum : NSUInteger {
    TriggerTypeOfBtnClick,
    TriggerTypeOfScrViewScroll,
} TriggerType;

@interface SelecterToolsScrolView : UIScrollView


-(void)updateSelecterToolsIndex:(NSInteger )index;


-(instancetype)initWithSeleterConditionTitleArr:(NSArray *)titleArr withFrame:(CGRect )frame andBtnBlock:(BtnClick)btnClick;
@end
