//
//  RecordCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/3.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *datePick;
@property (weak, nonatomic) IBOutlet UILabel *creatDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIButton *epidBtn;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;


@end
