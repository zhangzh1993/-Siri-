//
//  WeBookCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/12.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
