//
//  IncomeModel.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/5/20.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface IncomeModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * month; //月份
@property (nonatomic,strong) NSString <Optional> * cash; //该月份的收益

@end
