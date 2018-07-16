//
//  HuaxiangCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowerModel.h"
@interface HuaxiangCell : UITableViewCell
@property (strong,nonatomic)FollowerModel * data;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhunshiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhundianLabel;
@property (weak, nonatomic) IBOutlet UILabel *tousuLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tousuWidth;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end
