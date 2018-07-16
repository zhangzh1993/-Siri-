//
//  UILable+StringFrame.m
//  ZengShouTong
//
//  Created by 张正浩 on 16/3/26.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "UILable+StringFrame.h"

@implementation UILable_StringFrame
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

@end
