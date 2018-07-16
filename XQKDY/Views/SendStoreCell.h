//
//  SendStoreCell.h
//  MaoWu
//
//  Created by 张正浩 on 16/8/4.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDetailModel.h"
@interface SendStoreCell : UITableViewCell
@property (nonatomic,strong) IncomeDetailModel *data;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLab;
@property (strong, nonatomic) IBOutlet UILabel *amountLab;
@end
