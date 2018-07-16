//
//  SearchCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/14.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *expressIdlabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end
