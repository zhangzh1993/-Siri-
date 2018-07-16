//
//  UIImage+Url.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/3/24.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage_Url : NSObject
+(CGSize)getImageSizeWithURL:(id)imageURL;
+ (NSString *)image2String:(UIImage *)image;
@end

