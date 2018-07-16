//
//  BaseViewController.h
//  MaoWu
//
//  Created by 张正浩 on 16/2/29.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <MBProgressHUDDelegate>

/**
 *  view上面显示提示
 *
 *  @param view       显示在的superView
 *  @param hint       显示文本
 *
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;


/**
 *  隐藏提示框
 *
 *  @param animated 是否动画隐藏
 */
- (void)hideHud:(BOOL)animated;


/**
 *  显示错误提示
 *
 *  @param error 错误信息
 *  @param view  显示的在view上
 */
- (void)showError:(NSString *)error toView:(UIView *)view;


/**
 *  显示成功提示
 *
 *  @param success 成功的文本
 *  @param view    显示的在view上
 */
- (void)showSuccess:(NSString *)success toView:(UIView *)view;



@end
