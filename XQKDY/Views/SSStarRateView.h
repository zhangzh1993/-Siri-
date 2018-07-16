//
//  SSStarRateView.h
//  shansong
//
//  Created by admin on 15/5/27.
//  Copyright (c) 2015年 sunyuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStarRateView;
@protocol SSStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(SSStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface SSStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, copy)   NSString *grayStarString; //灰色星星
@property (nonatomic, copy)   NSString *checkStarString; //选中的星星
@property (nonatomic, assign) BOOL isSelectStar;//是否允许选中星星 默认为YES

@property (nonatomic, assign) BOOL isZeroScore;//是否可以0分。（当显示时，可以0分；当评价时，不可以0分），默认为YES

@property (nonatomic, weak) id<SSStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars grayStarString:(NSString *)grayStarString checkStarString:(NSString *)checkStarString;

@end
