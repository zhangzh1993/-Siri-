//
//  IncomeDateModel.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/5/20.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface IncomeDateModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * date; //日期
@property (nonatomic,strong) NSString <Optional> * money; //订单
@property (nonatomic,strong) NSMutableArray <Optional> * value; //金额

@end
