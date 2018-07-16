//
//  messageListModel.h
//  ZhuanTiKu_GWY
//
//  Created by yangyu on 16/7/11.
//  Copyright © 2016年 youbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messageListModel : NSObject
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) NSString *express_id;
@property (nonatomic, copy) NSString *express_state;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *date_recived_expor;
@property (nonatomic, copy) NSDictionary *expor;
@property (nonatomic, copy) NSString * mDate;

@end
