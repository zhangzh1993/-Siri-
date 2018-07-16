//
//  TagCell.h
//  XQKDY
//
//  Created by 张正浩 on 2017/5/5.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSelectionTagView.h"
@interface TagCell : UITableViewCell<MGSelectionTagViewDataSource,MGSelectionTagViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD * HUD;
}

@property (nonatomic, strong)NSDictionary * data;
@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;
@property (weak, nonatomic) IBOutlet MGSelectionTagView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeight;
@property (strong, nonatomic) NSMutableArray * tagArr;
@end
