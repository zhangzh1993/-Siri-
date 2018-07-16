//
//  UIView+Extension.m
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/16.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

/*width*/
- (CGFloat)sl_width {
  return CGRectGetWidth(self.frame);
}

- (void)setSl_width:(CGFloat)sl_width {
  CGRect frame = self.frame;
  frame.size.width = sl_width;
  self.frame = frame;
}

/*height*/
- (CGFloat)sl_height {
  return CGRectGetHeight(self.frame);
}

- (void)setSl_height:(CGFloat)sl_height {
  CGRect frame = self.frame;
  frame.size.height = sl_height;
  self.frame = frame;
}

/*frame.origin.x*/
- (CGFloat)sl_x {
  return CGRectGetMinX(self.frame);
}

- (void)setSl_x:(CGFloat)sl_x {
  CGRect frame = self.frame;
  frame.origin.x = sl_x;
  self.frame = frame;
}

/*frame.origin.y*/
- (void)setSl_y:(CGFloat)sl_y {
  CGRect frame = self.frame;
  frame.origin.y = sl_y;
  self.frame = frame;
}

- (CGFloat)sl_y {
  return CGRectGetMinY(self.frame);
}
@end