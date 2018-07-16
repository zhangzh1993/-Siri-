
//
//  BaseViewController.m
//  MaoWu
//
//  Created by 张正浩 on 16/2/29.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>

@interface BaseViewController ()

/**
 *  请求提示对象
 */
@property (nonatomic ,strong) MBProgressHUD *hub;//加载提示

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark -
#pragma mark - 显示提示
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
{
    if (_hub)
    {
        [_hub removeFromSuperview];
        _hub = nil;
    }
    
    _hub = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:_hub];
    
    
//    NSLog(@"提示文本显示在view上：%@ 提示文本的字符串长度：%ld 字符串的字符长度：%d",hint,[hint length],[Global lengthToInt:hint]);
    
    if ([Global lengthToInt:hint]>30)
    {
        _hub.detailsLabelText = hint;
        _hub.detailsLabelFont = [UIFont systemFontOfSize:15];
        _hub.detailsLabelColor = [UIColor whiteColor];
    }
    else
    {
        _hub.labelText = hint;
    }
    
    
    //    _hub.labelText = hint;
    
    [_hub show:YES];
    
    _hub.removeFromSuperViewOnHide = YES;
    
}


#pragma mark -
#pragma mark - 隐藏提示
- (void)hideHud:(BOOL)animated
{
    [_hub hide:animated];
}


#pragma mark -
#pragma mark - 显示错误提示
- (void)showError:(NSString *)error toView:(UIView *)view;
{
    [self show:error icon:@"error@2x.png" view:view];
}


#pragma mark -
#pragma mark - 显示成功提示
- (void)showSuccess:(NSString *)success toView:(UIView *)view;
{
    [self show:success icon:@"success@2x.png" view:view];
}


#pragma mark -
#pragma mark -  显示自定义信息
- (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    
    if ([Global lengthToInt:text]>30)
    {
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont systemFontOfSize:15];
        hud.detailsLabelColor = [UIColor whiteColor];
    }
    else
    {
        hud.labelText = text;
    }
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    if ([Global lengthToInt:text]>30)
    {
        [hud hide:YES afterDelay:2];
    }
    else
    {
        [hud hide:YES afterDelay:1];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
