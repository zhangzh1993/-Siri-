//
//  PhoneStateModel.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/8/17.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface PhoneStateModel : BaseModel
@property (nonatomic,strong) NSString <Optional>*phone;//电话
@property (nonatomic,strong) NSString <Optional>*sendType;//数量
@property (nonatomic,strong) NSString <Optional>*sendTypeCN;//类型
@end
