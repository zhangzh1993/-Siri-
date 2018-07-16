//
//  XMNumCell.h
//  拨号盘
//
//  Created by zyh on 16/6/12.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMNumData.h"
#define KSCREENW [UIScreen mainScreen].bounds.size.width
#define KSCREENH [UIScreen mainScreen].bounds.size.height
#define KSCALE  /375.0 * KSCREENW

typedef void(^NumBlock)();
@interface XMNumCell : UICollectionViewCell
@property (nonatomic,strong) UIButton *numberBtn;
@property (nonatomic,strong) XMNumData *data;
@property (nonatomic,copy) NumBlock numBlock;
@end
