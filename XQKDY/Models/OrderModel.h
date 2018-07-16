//
//  OrderModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/23.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel
@property (nonatomic,strong) NSString <Optional> * oid; //日期
@property (nonatomic,strong) NSString <Optional> * epid; //日期
@property (nonatomic,strong) NSString <Optional> * expressState; //订单
@property (nonatomic,strong) NSString <Optional> * expressStateCN; //金额
@property (nonatomic,strong) NSString <Optional> * cid; //金额
@property (nonatomic,strong) NSString <Optional> * comName; //金额
@property (nonatomic,strong) NSString <Optional> * signType;  //金额
@property (nonatomic,strong) NSString <Optional> * signTypeCN;  //金额
@property (nonatomic,strong) NSString <Optional> * note;  //金额
@property (nonatomic,strong) NSString <Optional> * dateCreate;  //金额
@property (nonatomic,strong) NSString <Optional> * dateSigned;  //金额
@property (nonatomic,strong) NSString <Optional> * dateBack;  //金额
@property (nonatomic,strong) NSString <Optional> * dateEnd;  //金额
@property (nonatomic,strong) NSString <Optional> * dateDestory;  //金额
@property (nonatomic,strong) NSDictionary * microButler;  //金额
@end
