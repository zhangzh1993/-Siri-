//
//  PhoneNumberCell.h
//  ZengShouTong
//
//  Created by 张正浩 on 16/7/16.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneNumberCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *iconNumber;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIImageView *stateImageView;
@property (strong, nonatomic) IBOutlet UITextField *expressId;

@end
