//
//  RechargeModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/14.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface RechargeModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * create_date; //日期
@property (nonatomic,strong) NSString <Optional> * charge_val; //订单
@property (nonatomic,strong) NSString <Optional> * charge_status; //金额

@end
