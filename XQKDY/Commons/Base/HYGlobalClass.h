
//
//  HYGlobalClass.h
//  CompressImage
//
//  Created by hy_les on 15/12/25.
//  Copyright © 2015年 HL. All rights reserved.
//
/* 单例 */

#import <Foundation/Foundation.h>

#define Global [HYGlobalClass getInstance]

@interface HYGlobalClass : NSObject
{
    float lastImageSize;
}

/*
 * 获取单例对象方法
 */
+(HYGlobalClass *) getInstance;//单例类对象获取方法


/**
 *  将图片压缩到指定的大小
 *
 *  @param image 待处理的图片
 *
 *  @return 返回处理后的图片
 */
-(UIImage *)compressionImageToLimitSizeWithImage:(UIImage *)image;


/**
 *  判断图片大小是否超出限定的大小
 *
 *  @param  orgImage 要测试的图片
 *
 *  @return YES:符合要求 NO：不符合要求
 */
-(BOOL)judgeImageWhetherMeetTheRequiredSize:(UIImage *)orgImage;

/**
 *  保存图片到沙河路径
 *
 *  @param image 图片
 *  @param name  图片名称
 */
-(void)saveImageToSandBox:(UIImage *)image withImageName:(NSString *)name;


/**
 *  得到字符串长度 中英文混合情况下
 *
 *  @param string 传入字符串
 *
 *  @return int 返回字符串长度
 */
- (int)lengthToInt:(NSString*)string;


@end
