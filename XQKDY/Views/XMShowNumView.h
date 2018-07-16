//
//  XMShowNumView.h
//  Efetion
//
//  Created by zyh on 16/6/14.
//
//

#import <UIKit/UIKit.h>
@protocol XMShowNumViewDelegate <NSObject>
@optional
-(void)deleteAll;
@required
-(void)deleteOneByOne;
@end
@interface XMShowNumView : UIView
@property (nonatomic,strong) UILabel *inputNumberLabel;
@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,assign) id <XMShowNumViewDelegate> delegate;
@end
