//
//  SSStarRateView.m
//  shansong
//
//  Created by admin on 15/5/27.
//  Copyright (c) 2015年 sunyuqiang. All rights reserved.
//

#import "SSStarRateView.h"

//star_small_check
//star_gray
#define FOREGROUND_STAR_IMAGE_NAME @"star_check"
#define BACKGROUND_STAR_IMAGE_NAME @"pj_star_big_yellow"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface SSStarRateView ()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@end

@implementation SSStarRateView

#pragma mark - Init Methods
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER grayStarString:BACKGROUND_STAR_IMAGE_NAME checkStarString:FOREGROUND_STAR_IMAGE_NAME];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = DEFALUT_STAR_NUMBER;
        [self buildDataAndUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars grayStarString:(NSString *)grayStarString checkStarString:(NSString *)checkStarString
{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        self.grayStarString = grayStarString;
        self.checkStarString = checkStarString;
        [self buildDataAndUI];
//        [[SSNotificationCenter sharedInstance] addDelegate:self];
    }
    return self;

}
#pragma mark - Private Methods

- (void)buildDataAndUI {
    _scorePercent = 1;//默认为1
    _hasAnimation = NO;//默认为NO
    _allowIncompleteStar = NO;//默认为NO
    _isSelectStar = YES;//默认为YES
    _isZeroScore = YES;//默认为YES
    
    self.foregroundStarView = [self createStarViewWithImage:self.checkStarString];
    self.backgroundStarView = [self createStarViewWithImage:self.grayStarString];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
//    tapGesture.numberOfTapsRequired = 1;
//    [self addGestureRecognizer:tapGesture];
}

//- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
//    CGPoint tapPoint = [gesture locationInView:self];
//    CGFloat offset = tapPoint.x;
//    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
//    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
//    if (_isSelectStar) {
//        self.scorePercent = starScore / self.numberOfStars;
//        [[[SSNotificationCenter sharedInstance]defaultCenter]starDidChange:starScore];
//    }
//    else{
//        [[[SSNotificationCenter sharedInstance]defaultCenter]starDidNotChange:starScore];
//    }  
//}

//触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self starScoreChangedWithPoint:point isNotification:NO];
}

//触摸停止
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self starScoreChangedWithPoint:point isNotification:YES];
}

-(void)starScoreChangedWithPoint:(CGPoint)point isNotification:(BOOL)isNotification
{
    CGFloat offset = point.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
    if (_isSelectStar) {
        self.scorePercent = starScore / self.numberOfStars;
        //触摸停止后，发送通知，触摸移动过程中，不发送通知
        if (isNotification) {
//            [[[SSNotificationCenter sharedInstance]defaultCenter]starDidChange:starScore];
        }
    }
    else{
//        [[[SSNotificationCenter sharedInstance]defaultCenter]starDidNotChange:starScore];
    }
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 3, self.bounds.size.width / self.numberOfStars, self.bounds.size.height - 6);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak SSStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }

    if (scroePercent <= 0) {
        if (_isZeroScore) {
            _scorePercent = 0;
        }else{
            _scorePercent = 0.2;
        }
        
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    _isZeroScore = NO;
    [self setNeedsLayout];
}

- (void)dealloc
{
    [self clearDelegates];
}

- (void)clearDelegates
{
//    [[SSNotificationCenter sharedInstance] removeDelegate:self];
}

@end

