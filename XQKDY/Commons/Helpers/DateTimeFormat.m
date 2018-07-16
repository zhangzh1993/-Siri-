//
//  DateTimeFormat.m
//  smartlock
//
//  Created by Steve Wind on 16/8/24.
//  Copyright © 2016年 bis. All rights reserved.
//

#import "DateTimeFormat.h"
#import <CommonCrypto/CommonDigest.h>

@implementation DateTimeFormat


//根据时间戳获取时间
+(NSDate *)getDateTimeFromeSin97:(long long)interval{
    
   return [NSDate dateWithTimeIntervalSince1970:interval / 1000];
}
//根据时间获取时间戳
+(long long)longLongFromDate:(NSDate*)date{
    return [date timeIntervalSince1970] * 1000;
}
//获取日期
+(NSString *)getTimeDay:(NSDate *)dateInput{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *confromTimespStr = [formatter stringFromDate:dateInput];
    return confromTimespStr;
}
//MM-dd
+(NSString *)getDay:(NSDate *)dateInput{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    NSString *confromTimespStr = [formatter stringFromDate:dateInput];
    return confromTimespStr;
}
//获取时间  hh：mm
+(NSString *)getTime:(NSDate *)dateInput{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    NSString *confromTimespStr = [formatter stringFromDate:dateInput];
    return confromTimespStr;
}

//获取day 天后的时间
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day

{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:day];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
}


//md5 64位 加密 （小写）


+ (NSString *)md5low:(NSString *) input {
    input =[NSString stringWithFormat:@"@%@#",input];
    const char  *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}



@end
