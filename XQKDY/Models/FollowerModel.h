//
//  FollowerModel.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "BaseModel.h"

@interface FollowerModel : BaseModel

/**
 *  img_Url
 */
@property (nonatomic,copy) NSString *date;

/**
 *  nickname
 */
@property (nonatomic,copy) NSString *nickname;

/**
 *  nickname
 */
@property (nonatomic,copy) NSString *place;

/**
 *  nickname
 */
@property (nonatomic,copy) NSString *time;

/**
 *  nickname
 */
@property (nonatomic,copy) NSString *complainTimes;
@end
