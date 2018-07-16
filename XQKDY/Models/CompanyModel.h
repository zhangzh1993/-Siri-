//
//  CompanyModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/12.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface CompanyModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * cid; //日期
@property (nonatomic,strong) NSString <Optional> * comName; //订单
@property (nonatomic,strong) NSString <Optional> * amount; //金额
@end
