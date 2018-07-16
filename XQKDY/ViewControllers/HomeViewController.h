//
//  HomeViewController.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineImageWidth;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *headIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *fabuLabel;
@property (weak, nonatomic) IBOutlet UILabel *liulanLabel;
@property (weak, nonatomic) IBOutlet UILabel *goumaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yingshouLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenrunLabel;
@property (weak, nonatomic) IBOutlet UILabel *shangshengLabel;
@property (weak, nonatomic) IBOutlet UILabel *mingciLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chaoguoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fensiLabel;
@property (weak, nonatomic) IBOutlet UIButton *speakBtn;
- (IBAction)call:(UIButton *)sender;
- (IBAction)right:(UIButton *)sender;
- (IBAction)star:(UIButton *)sender;
- (IBAction)webook:(UIButton *)sender;

@end
