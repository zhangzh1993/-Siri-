//
//  IncomeDetailModel.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/5/20.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface IncomeDetailModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * title; //订单号
@property (nonatomic,strong) NSString <Optional> * amount; //订单号
@property (nonatomic,strong) NSString <Optional> * price;//运费

@end
