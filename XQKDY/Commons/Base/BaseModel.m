//
//  BaseModel.m
//  ZengShouTong
//
//  Created by 张正浩 on 16/4/19.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    NSError *error = nil;
    self =  [self initWithDictionary:dic error:&error];
    return self;
}

@end

