//
//  Response.m
//  MVVM-demo
//
//  Created by shen_gh on 16/4/12.
//  Copyright © 2016年 申冠华. All rights reserved.
//

#import "Response.h"

@implementation Response

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    kEnumServerState flag=kEnumServerStateSuccess;
    NSObject *data=@"";
    NSString *message=@"";
    NSString *status=@"";
    NSString *total=@"";
    if ([dic valueForKey:@"code"]) {
        flag=[[dic valueForKey:@"code"]intValue];
    }
    data=[dic objectForKey:@"list"];
    if ([dic valueForKey:@"data"]) {
        data=[[dic objectForKey:@"data"] valueForKey:@"list"];
    }
    if ([[dic valueForKey:@"data"] valueForKey:@"rid"]) {
        data=[dic objectForKey:@"data"];
    }
    if ([[dic valueForKey:@"data"] valueForKey:@"total"]) {
        data=[dic objectForKey:@"data"];
    }
    message=[dic valueForKey:@"msg"];
    status=[dic valueForKey:@"status"];
    total=[dic valueForKey:@"total"];
    return [self initWithState:flag result:data message:message total:total];
}
- (Response *)initWithState:(kEnumServerState)state result:(NSObject *)data message:(NSString *)message total:(NSString *)total{
    self=[super init];
    if (self) {
        _status=state;
        _data=data;
        _msg=message;
        _total = total;
    }
    return self;
}
- (NSString *)description{
    return [NSString stringWithFormat:@"status=%@, data=%@, message=%@",@(_status), _data,_msg];
}

@end
