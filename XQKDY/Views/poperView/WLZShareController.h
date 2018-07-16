//
//  WLZShareController.h
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZBlockButton.h"
@interface WLZShareController : UIViewController
@property (nonatomic)BOOL isOther;
@property (nonatomic)BOOL isType;
@property (nonatomic)BOOL isShunfeng;
@property (nonatomic)BOOL isZhuanJi;
@property (nonatomic)BOOL isNotice;
@property (nonatomic, strong)NSMutableArray * otherArr;
@property (nonatomic, strong) UIView *contentView;


- (void)addItem:(NSString *)title icon:(NSString *)icon   block:(void (^)(WLZBlockButton *))block ;


-(void)show;

@end
