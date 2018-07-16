//
//  DropView.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UIView *recentView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *recentBtn;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *day_3Btn;
@property (weak, nonatomic) IBOutlet UIButton *day_7Btn;
@property (weak, nonatomic) IBOutlet UIButton *day_30Btn;
@property (weak, nonatomic) IBOutlet UIButton *time_3Btn;
@property (weak, nonatomic) IBOutlet UIButton *time_7Btn;
@property (weak, nonatomic) IBOutlet UIButton *time_30Btn;
@property (weak, nonatomic) IBOutlet UIButton *other_1Btn;
@property (weak, nonatomic) IBOutlet UIButton *other_2Btn;
@property (weak, nonatomic) IBOutlet UIImageView *sendImageView;
@property (weak, nonatomic) IBOutlet UIImageView *recentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UIView *cateContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryHeight;

@end
