
//
//  MessageLisetLayout.m
//  ZhuanTiKu_GWY
//
//  Created by yangyu on 16/7/11.
//  Copyright © 2016年 youbinbin. All rights reserved.
//

#import "MessageLisetLayout.h"

@implementation MessageLisetLayout

+ (instancetype)layoutWithMessageModel:(messageListModel *)model {
    MessageLisetLayout *layout = [[MessageLisetLayout alloc] initWithModel:model];
    return layout;
}

- (instancetype)initWithModel:(messageListModel *)model {
    if (self = [super init]) {
        _listMode = model;
        [self layout];
    }
    return self;
}

//更改字体 判断逻辑 等等 在这方法里面写
- (void)layout {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_listMode.mDate integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *DateTime = [formatter stringFromDate:date];
    self.creatdate = DateTime;
    self.mid = _listMode.express_id;
    switch ([_listMode.express_state integerValue]) {
        case 0:
            self.title = @"上门派件";
            break;
        case 1:
            self.title = @"上门取件";
            break;
        case 2:
            self.title = @"投诉任务";
            break;
            
        default:
            break;
    }

    self.phone = [NSString stringWithFormat:@"客户信息: %@  %@",[_listMode.expor valueForKey:@"customerName"],[_listMode.expor valueForKey:@"customerPhone"]];
    self.date = [NSString stringWithFormat:@"详细地址: %@",[_listMode.expor valueForKey:@"customerAddress"]];
    self.content = [NSString stringWithFormat:@"备注详情:%@",[_listMode.expor valueForKey:@"note"]];
    self.isSelected = _listMode.isSelected;
}
@end
