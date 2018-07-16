//
//  MessageLisetLayout.h
//  ZhuanTiKu_GWY
//
//  Created by yangyu on 16/7/11.
//  Copyright © 2016年 youbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "messageListModel.h"
@interface MessageLisetLayout : NSObject

+ (instancetype)layoutWithMessageModel:(messageListModel *)model;

@property (nonatomic, strong) messageListModel *listMode;;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString * creatdate;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL isSelected;
@end
