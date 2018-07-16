//
//  shangouModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/10.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface shangouModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * title; //日期
@property (nonatomic,strong) NSString <Optional> * fee; //订单
@property (nonatomic,strong) NSString <Optional> * payDate; //金额
@end
