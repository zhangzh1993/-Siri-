//
//  UIImage+colorImage.m
//  newsOfWangYi
//
//  Created by AS150701001 on 15/12/22.
//  Copyright (c) 2015年 lele. All rights reserved.
//

#import "UIImage+colorImage.h"

@implementation UIImage (colorImage)
// 用颜色创建一个图片
+(UIImage*) imageWithColor:(UIColor*) color
{
    CGFloat imageW=100;
    CGFloat imageH=49;
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    // 画一个 color 颜色的矩形框
    [color setFill];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    // 渲染
    UIImage* image= UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
