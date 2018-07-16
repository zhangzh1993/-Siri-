//
//  Picker.h
//  MaoWu
//
//  Created by 张正浩 on 16/3/10.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Picker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,retain)NSMutableArray *firstData;
@property (nonatomic,retain)NSMutableArray *codeData;
@property (nonatomic,retain)NSString *firstStr;
@property (nonatomic,retain)NSString *firstCode;
@end