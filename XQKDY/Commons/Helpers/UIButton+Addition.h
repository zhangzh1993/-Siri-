//
//  UIButton+Addition.h
//  TWApp
//
//  Created by line0 on 13-7-11.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ColorButtonBackground [UIColor grayColor]
#define FontSizeOfButton 15
@interface UIButton (Addition)
/**
 指定两个状态的图片,返回一个button
 */
+ (UIButton *)buttonWithNImage:(UIImage *)nimage pImage:(UIImage *)pImage delegate:(id)del selector:(SEL)sel;

/**
 * 传入一个可伸缩的图片,返回一个按钮
 * 图片大小 宽度&高度:由参数指定
 */
+ (UIButton *)buttonWithNormalImage:(UIImage *)image andTitle:(NSString*)title width:(CGFloat)aWidth height:(CGFloat)aHeight target:(id)aTarget selector:(SEL)aSelector;
/**
 * 传入一个NSString,返回一个按钮
 * 按钮颜色的样式可以通过更改宏定义 ColorButtonBackground
 */
+ (UIButton *)buttonWithStr:(NSString *)strTitle;
+ (UIButton *)buttonReverseColorWithStr:(NSString *)strTitle;
+ (UIButton *)buttonLoginWithStr:(NSString *)strTitle;
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)t target:(id)tgt action:(SEL)a;

@end
