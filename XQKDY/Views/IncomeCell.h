//
//  IncomeCell.h
//  MaoWu
//
//  Created by 张正浩 on 16/4/27.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDateModel.h"
@interface IncomeCell : UITableViewCell
@property (nonatomic,strong) IncomeDateModel *data;
@property (nonatomic, retain) NSString * monthStr;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *amountLab;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;
@property (strong, nonatomic) IBOutlet UILabel *sendLab;
@property (strong, nonatomic) IBOutlet UILabel *backLab;

@end
