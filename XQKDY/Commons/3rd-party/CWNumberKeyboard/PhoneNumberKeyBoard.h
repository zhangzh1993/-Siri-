//
//  PhoneNumberKeyBoard.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/5/6.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneNumberKeyBoard : UIView
typedef void(^numberKeyboardBlock)(NSString *priceString);
@property (nonatomic)BOOL isPhone;
- (void)showNumKeyboardViewAnimateWithPrice:(NSString *)priceString andBlock:(numberKeyboardBlock)block;
- (void)hideNumKeyboardViewWithAnimateWithConfirm:(BOOL)isConfirm;
@end
