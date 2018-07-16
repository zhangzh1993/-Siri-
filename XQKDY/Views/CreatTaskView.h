//
//  CreatTaskView.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/13.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatTaskView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *pickBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *tousuBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseTime;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *chooseTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end
