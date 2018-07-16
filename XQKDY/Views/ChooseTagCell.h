//
//  ChooseTagCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/9.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSelectionTagView.h"

@interface ChooseTagCell : UITableViewCell<MGSelectionTagViewDataSource,MGSelectionTagViewDelegate,MBProgressHUDDelegate>
{
    UILabel * titleLab;
    UITextField * classifyTextField;
    MBProgressHUD * HUD;
}
@property (nonatomic, strong)NSDictionary * data;
@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;
@property (weak, nonatomic) IBOutlet MGSelectionTagView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeight;
@property (strong, nonatomic) NSMutableArray * tagArr;
@property (strong, nonatomic) NSMutableArray * tagSelectArr;
@property (strong, nonatomic) NSMutableArray * selectIndexArr;
@property (strong, nonatomic) UIView * bgView;
@property (strong, nonatomic) UIView * publishView;
@end
