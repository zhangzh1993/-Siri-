//
//  PersonCell.h
//  BM
//
//  Created by yuhuajun on 15/7/13.
//  Copyright (c) 2015年 yuhuajun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
@class CDFInitialsAvatar;
@interface PersonCell : UITableViewCell

@property(strong,nonatomic)PersonModel *personDel;
@property(strong,nonatomic)UILabel *youlable;
@property(strong,nonatomic)UILabel * addresslable;
@property(strong,nonatomic)UILabel *txtName;
@property(strong,nonatomic)UIImageView *tximg;
@property(strong,nonatomic)UILabel *nickName;
@property(strong,nonatomic)UILabel *phoneNum;
@property(strong,nonatomic)UIImageView * iconImageView;
@property(strong,nonatomic)CDFInitialsAvatar *topAvatar;
-(void)setData:(PersonModel*)personDel;

@end
