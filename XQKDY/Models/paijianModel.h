//
//  paijianModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/10.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface paijianModel : BaseModel

@property (nonatomic,strong) NSString <Optional> * epid; //日期
@property (nonatomic,strong) NSString <Optional> * expressType; //订单
@property (nonatomic,strong) NSString <Optional> * date; //金额
@end
