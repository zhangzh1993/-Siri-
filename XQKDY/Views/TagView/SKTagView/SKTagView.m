//
//  SKTagView.m
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagView.h"
#import "SKTagButton.h"
#import "TCAlertView.h"

@interface SKTagView ()<TCAlertViewDelegate>
{
    NSTimer * timer;
    CGFloat count;
    NSUInteger deleteindex ;
}
@property (strong, nonatomic) TCAlertView * alertView;
@property (strong, nonatomic, nullable) NSMutableArray *tags;
@property (assign, nonatomic) BOOL didSetup;
@property(nonatomic,assign)BOOL outOfBounds;

@end

@implementation SKTagView

#pragma mark - Lifecycle

-(CGSize)intrinsicContentSize {
    if (!self.tags.count) {
        return CGSizeZero;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat bottomPadding = self.padding.bottom;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        NSInteger lineCount = 0;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    currentX += size.width;
                } else {
                    lineCount ++;
                    currentX = leftPadding + size.width;
                    intrinsicHeight += size.height;
                }
            } else {
                lineCount ++;
                intrinsicHeight += size.height;
                currentX += size.width;
            }
            previousView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightPadding);
        }
        
        intrinsicHeight += bottomPadding + lineSpacing * (lineCount - 1);
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            intrinsicWidth += size.width;
        }
        intrinsicWidth += itemSpacing * (subviews.count - 1) + rightPadding;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomPadding;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews {
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
    
    [self layoutTags];
}

#pragma mark - Custom accessors

- (NSMutableArray *)tags {
    if(!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (void)setPreferredMaxLayoutWidth: (CGFloat)preferredMaxLayoutWidth {
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        _didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Private

- (void)layoutTags {
    if (self.didSetup || !self.tags.count) {
        return;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat bottomPadding = self.padding.bottom;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        if (self.outOfBounds) return;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    if (CGRectGetMaxY(previousView.frame) + lineSpacing < self.bounds.size.height - bottomPadding) {
                        view.frame = CGRectMake(currentX, CGRectGetMinY(previousView.frame), size.width, size.height);
                        currentX += size.width;
                    }else{
                        [view removeFromSuperview];
                        self.outOfBounds = YES;
                        break;
                    }
                    
                } else {
                    CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                    if (CGRectGetMaxY(previousView.frame) + lineSpacing < self.bounds.size.height - bottomPadding) {
                        view.frame = CGRectMake(leftPadding, CGRectGetMaxY(previousView.frame) + lineSpacing, width, size.height);
                        currentX = leftPadding + width;
                    }else{
                        [view removeFromSuperview];
                        self.outOfBounds = YES;
                        break;
                    }
                }
            } else {
                CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                view.frame = CGRectMake(leftPadding, topPadding, width, size.height);
                currentX += width;
            }
            
            previousView = view;
        }
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            view.frame = CGRectMake(currentX, topPadding, size.width, size.height);
            currentX += size.width;
            currentX += itemSpacing;
            
            previousView = view;
        }
    }
    
    NSLog(@"%@",NSStringFromCGRect(previousView.frame));
    
    self.didSetup = YES;
    
    if ([_isStore intValue] == 1) {
        NSDictionary * dic = @{
                               @"height":[NSString stringWithFormat:@"%.2f",CGRectGetMaxY(previousView.frame) + lineSpacing],
                               @"isother":@"isStore",
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherTagViewHeight" object:nil userInfo:dic];
    }
    else if ([_isOther intValue] == 1) {
        NSDictionary * dic = @{
                               @"height":[NSString stringWithFormat:@"%.2f",CGRectGetMaxY(previousView.frame) + lineSpacing],
                               @"isother":@"isOther",
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherTagViewHeight" object:nil userInfo:dic];
    }
    else if ([_isOther intValue] == 0) {
        NSDictionary * dic = @{
                               @"height":[NSString stringWithFormat:@"%.2f",CGRectGetMaxY(previousView.frame) + lineSpacing],
                               @"isother":@"guizi",
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherTagViewHeight" object:nil userInfo:dic];
    }
    else{
        
        NSDictionary * dic = @{
                               @"height":[NSString stringWithFormat:@"%.2f",CGRectGetMaxY(previousView.frame) + lineSpacing],
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TagViewHeight" object:nil userInfo:dic];
    }
    
}

#pragma mark - IBActions

- (void)onTag: (UIButton *)btn {
    NSLog(@"计时结束");
    [timer invalidate];
    
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)view;
            [btn setSelected:NO];
        }
    }
    
    if (![btn.titleLabel.text isEqualToString:@"   +   "]) {
        btn.selected = !btn.selected;
    }
    
    if (count > 0.5) {
        [timer invalidate];
        [self removeTag:self.tags[[self.subviews indexOfObject: btn]]];
    }
    else{
        if (self.didTapTagAtIndex) {
            self.didTapTagAtIndex([self.subviews indexOfObject: btn]);
        }
    }
}

#pragma mark - Public

- (void)addTag: (SKTag *)tag {
    
    if (self.outOfBounds) return;
    
    NSParameterAssert(tag);
    SKTagButton *btn = [SKTagButton buttonWithTag: tag];
    
    [btn addTarget:self action:@selector(offsetButtonTouchBegin:)forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(onTag:)forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(offsetButtonTouchEnd:)forControlEvents:UIControlEventTouchUpOutside];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_bg_time_default_"] forState:0];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_bg_time_selected_"] forState:UIControlStateSelected];
    [self addSubview: btn];
    [self.tags addObject: tag];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}


-(void) offsetButtonTouchBegin:(id)sender{
    NSLog(@"开始计时");
    
    count = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    [timer fire];
    
    
}

-(void) offsetButtonTouchEnd:(id)sender{
    NSLog(@"计时结束");
    
    
    [timer invalidate];
    NSLog(@"count = %f",count);
    
}
-(void) handleTimer:(id)sender{
    count = count + 0.1;
    NSLog(@"%f",count);
    
}
- (void)insertTag: (SKTag *)tag atIndex: (NSUInteger)index {
    if(self.outOfBounds) return;
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count) {
        [self addTag: tag];
    } else {
        SKTagButton *btn = [SKTagButton buttonWithTag: tag];
        [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
        [self insertSubview: btn atIndex: index];
        [self.tags insertObject: tag atIndex: index];
        
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}
- (void)requestEventAction:(UIButton *)button
{

    SKTag * tag = self.tags[deleteindex];


    

    [self.alertView closeView];
 
}
- (void)removeTag: (SKTag *)tag {
    
    NSParameterAssert(tag);
    NSLog(@"~~~~~~~~tag:%@",tag);
    deleteindex = [self.tags indexOfObject: tag];
    if (NSNotFound == deleteindex) {
        return;
    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该标签？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.tag == 113) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
            
            NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,klabellibUrl];
            NSDictionary * dic2 = @{
                                    @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                    @"title":@"smsLabel",
                                    @"labelname":tag.text,
                                    };
            NSLog(@"~~~~~~dic:%@",dic2);
            [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"~~~~~~~response:%@",response);
                NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                if ([[json valueForKey:@"code"] intValue]==10000) {
                    NSLog(@"点击确认");
                    if (self.didRemoveTagAtIndex) {
                        self.didRemoveTagAtIndex(deleteindex);
                    }
                    [self.tags removeObjectAtIndex: deleteindex];
                    
                    if (self.subviews.count > deleteindex) {
                        [self.subviews[deleteindex] removeFromSuperview];
                        self.outOfBounds = NO;
                    }
                    [self layoutTags];
                    
                    self.didSetup = NO;
                    [self invalidateIntrinsicContentSize];
                }
                else
                {
                    
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                
            }];
        }
        if (self.tag == 112) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
            
            NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kexpresscabinettodelUrl];
            NSDictionary * dic2 = @{
                                    @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                    @"cabId":tag.cbid.length > 0 ?tag.cbid:@"",
                                    };
            NSLog(@"~~~~~~dic:%@",dic2);
            [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"~~~~~~~response:%@",response);
                NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                if ([[json valueForKey:@"code"] intValue]==10000) {
                    NSLog(@"点击确认");
                    if (self.didRemoveTagAtIndex) {
                        self.didRemoveTagAtIndex(deleteindex);
                    }
                    [self.tags removeObjectAtIndex: deleteindex];
                    
                    if (self.subviews.count > deleteindex) {
                        [self.subviews[deleteindex] removeFromSuperview];
                        self.outOfBounds = NO;
                    }
                    [self layoutTags];
                    
                    self.didSetup = NO;
                    [self invalidateIntrinsicContentSize];
                }
                else
                {
                    
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                
            }];
        }
        
    }]];
    [[self getCurrentViewController] presentViewController:alertController animated:YES completion:nil];
    
    
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
- (void)removeTagAtIndex: (NSUInteger)index {
    if (index + 1 > self.tags.count) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllTags {
    [self.tags removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

@end
