//
//  PlaceView.h
//  XQKDY
//
//  Created by 张正浩 on 2017/4/25.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
#import "TCAlertView.h"
@interface PlaceView : UITableViewCell<TCAlertViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD * HUD;
    UILabel * titleLab;
    UITextField * classifyTextField;
}
@property (strong, nonatomic) NSString * phoneStr;
@property (strong, nonatomic) NSString * tagStr;
@property (strong, nonatomic) NSString * cabIdStr;
@property (strong, nonatomic) NSString * shopIdStr;
@property (strong, nonatomic) SKTagView * storetagView;
@property (strong, nonatomic) SKTagView * guizitagView;
@property (strong, nonatomic) SKTagView * othertagView;
@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSMutableArray * tagArr;
@property (strong, nonatomic) NSMutableArray * tagIdArr;
@property (strong, nonatomic) NSMutableArray * ohterArr;
@property (strong, nonatomic) NSMutableArray * storeArr;
@property(nonatomic,assign)NSUInteger originalButtonCount;
@property (nonatomic, strong) TCAlertView *alertView;

@property (strong, nonatomic) UIView * bgView;
@property (strong, nonatomic) UIView * publishView;


- (IBAction)confirm:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *guiziViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeViewHeight;
@property (weak, nonatomic) IBOutlet UIView *guiziView;
@property (weak, nonatomic) IBOutlet UIView *otherView;
@property (weak, nonatomic) IBOutlet UIView *storeView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *StoreBtn;

@end
