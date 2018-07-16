//
//  WeBook.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/12.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface WeBook : BaseModel
@property (nonatomic,strong) NSString <Optional> * maid; //日期
@property (nonatomic,strong) NSString <Optional> * title; //订单
@property (nonatomic,strong) NSString <Optional> * indexPicUrl; //金额
@property (nonatomic,strong) NSString <Optional> * aType; //金额
@property (nonatomic,strong) NSString <Optional> * authorNickname; //金额
@property (nonatomic,strong) NSString <Optional> * authorPicUrl; //金额
@property (nonatomic,strong) NSString <Optional> * timesRead; //金额
@property (nonatomic,strong) NSString <Optional> * createDate; //金额
@end
