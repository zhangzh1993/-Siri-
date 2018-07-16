//
//  TCAlertView.h
//  TCAlertView
//
//  Created by Arthur on 2017/3/23.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCAlertViewDelegate <NSObject>

- (void)requestEventAction:(UIButton *)button;

@end


@interface TCAlertView : UIView


@property (nonatomic,weak) id <TCAlertViewDelegate> delegate;
@property (nonatomic,strong) NSString * isGuizi;

@property (nonatomic,strong) UITextField *remarkField;
@property (nonatomic,strong) UITextField *msgField;

@property (nonatomic,copy) NSString *titleString; //标题
@property (nonatomic,copy) NSString *remarkString; //小标题1
@property (nonatomic,copy) NSString *msgString; //小标题2

- (void)showView;
- (void)closeView;


@end
