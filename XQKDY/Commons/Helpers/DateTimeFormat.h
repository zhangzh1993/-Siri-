//
//  DateTimeFormat.h
//  smartlock
//
//  Created by Steve Wind on 16/8/24.
//  Copyright © 2016年 bis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTimeFormat : NSObject

//根据格林尼治时间获取日期
+(NSDate *)getDateTimeFromeSin97:(long long)interval;

//根据时间获取时间戳
+(long long)longLongFromDate:(NSDate*)date;

//获取时间  hh：mm
+(NSString *)getTime:(NSDate *)dateInput;

//获取日期YYYY-MM-DD
+(NSString *)getTimeDay:(NSDate *)dateInput;

//获取日期MM-dd
+(NSString *)getDay:(NSDate *)dateInput;

//获取day 天后的时间
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day;

//md5 64 小写
+ (NSString *)md5low:(NSString *)str;

@end
