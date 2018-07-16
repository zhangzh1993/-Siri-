//
//  UnDelayCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/3.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnDelayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *epIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@end
