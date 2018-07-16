//
//  StoreModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/13.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface StoreModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * shopName; //日期
@property (nonatomic,strong) NSString <Optional> * shopId; //订单
@property (nonatomic,strong) NSString <Optional> * address; //金额
@property (nonatomic,strong) NSString <Optional> * phone; //取派
@property (nonatomic,strong) NSString <Optional> * verify; //完美签收
@property (nonatomic,strong) NSString <Optional> * verifyCN; //派件收益
@end
