//
//  PhoneNumberKeyBoard.m
//  ZengShouTong
//
//  Created by 张正浩 on 16/5/6.
//  Copyright © 2016年 张正浩. All rights reserved.
//
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                 //屏幕宽度
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                //屏幕长度
#define CUSTOM_KEYBOARD_HEIGHT   260           //自定义键盘高度
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#import "PhoneNumberKeyBoard.h"

@interface PhoneNumberKeyBoard()
@property (weak, nonatomic) IBOutlet UITextField *mTextNumberFiled;
@property (strong, nonatomic) IBOutlet UIView *mKeyboardView;
@property (weak, nonatomic) IBOutlet UIButton * SMSBtn;
@property (weak, nonatomic) IBOutlet UIButton *mResignBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleBtn;
@property (nonatomic , copy) numberKeyboardBlock block;
@end

@implementation PhoneNumberKeyBoard
- (id)init
{
    self = [super init];
    
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumber:) name:@"VoiceNumber" object:nil];
        // 添加keyboardview
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self setBackgroundColor:RGBCOLORVA(0x000000, 0.2)];
        
        [[NSBundle mainBundle] loadNibNamed:@"PhoneNumber" owner:self options:nil];
            NSLog(@"~~~~~~%d",_isPhone);

        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapAction:)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleRecognizer];
        
        self.mKeyboardView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CUSTOM_KEYBOARD_HEIGHT);
        [self addSubview:self.mKeyboardView];
        _mTextNumberFiled.placeholder = @"请输入手机号";
        //将UITextField键盘设置为空 有光标 但是不弹出键盘 这一步很重要
        _mTextNumberFiled.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        [_mTextNumberFiled addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

        // 设置图片
        [self.SMSBtn setImage:[UIImage imageNamed:@"button_phone_-1"]
                         forState:UIControlStateNormal];
        [self.deleBtn setImage:[UIImage imageNamed:@"CWNumberKeyboard.bundle/delete.png"]
                         forState:UIControlStateNormal];
        [self.mResignBtn setImage:[UIImage imageNamed:@"CWNumberKeyboard.bundle/resign.png"]
                         forState:UIControlStateNormal];
    }
    
    return self;
}
-(void)phoneNumber:(NSNotification *)sender
{
    _mTextNumberFiled.text = sender.userInfo[@"number"];
}
- (void)textFieldChanged:(id)sender
{
    NSDictionary  * dic = @{
                            @"phone":_mTextNumberFiled.text,
                            };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneNum" object:nil userInfo:dic];
}

- (void)showNumKeyboardViewAnimateWithPrice:(NSString *)priceString andBlock:(numberKeyboardBlock)block{
    _block = block;
    float vaule = self.mTextNumberFiled.text.floatValue;
    [self.mTextNumberFiled setText:(0 == vaule)?@"":priceString];
    [self setBackgroundColor:RGBCOLORVA(0x000000, 0.2)];
    [UIView animateWithDuration:0.2 animations:^{
        self.mKeyboardView.frame = CGRectMake(0, SCREEN_HEIGHT-CUSTOM_KEYBOARD_HEIGHT-64, SCREEN_WIDTH, CUSTOM_KEYBOARD_HEIGHT);
        
    } completion:^(BOOL finished) {
        [self.mTextNumberFiled becomeFirstResponder];
    }];
}
- (void)hideNumKeyboardViewWithAnimateWithConfirm:(BOOL)isConfirm{
    [UIView animateWithDuration:0.2 animations:^{
        self.mKeyboardView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CUSTOM_KEYBOARD_HEIGHT);
        
    } completion:^(BOOL finished) {
        if (isConfirm) {
             _block(self.mTextNumberFiled.text);
        }
        [self.mTextNumberFiled resignFirstResponder];
        [self setBackgroundColor:[UIColor clearColor]];
        self.hidden = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"keyBoardHidden" object:nil];
    }];
}
-(void)bgViewTapAction:(UITapGestureRecognizer*)recognizer
{
    [self hideNumKeyboardViewWithAnimateWithConfirm:NO];
}

/*
 1000->0
 1001->1
 1002->2
 1003->3
 1004->4
 1005->5
 1006->6
 1007->7
 1008->8
 1009->9
 1010->.
 1011->消失
 1012->删除
 1013->确认
 */
- (IBAction)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    switch (tag)
    {
        case 1009:
        {
            // 删除
            if(self.mTextNumberFiled.text.length > 0)
                [self.mTextNumberFiled deleteBackward];
            
        }
            break;
        case 1010:
        {
            // 小数点
            if(self.mTextNumberFiled.text.length > 0 && ![self.mTextNumberFiled.text containsString:@"."]){
                [self.mTextNumberFiled insertText:@"."];
            }
            
        }
            break;
        case 1011:
        {
            // 取消
            [self hideNumKeyboardViewWithAnimateWithConfirm:NO];
        }
            break;
        case 1012:
        {
            // 发短信
            //确定 文本框失去焦点 并且下滑消失
            [self hideNumKeyboardViewWithAnimateWithConfirm:NO];
            NSDictionary * dic  = @{
                                    @"phoneNum":self.mTextNumberFiled.text,
                                    };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SendSMS" object:nil userInfo:dic];

        }
            break;
        case 1013:
        {
            //确定 文本框失去焦点 并且下滑消失
            [self hideNumKeyboardViewWithAnimateWithConfirm:YES];
            
            
        }
            break;
        default:
        {
            // 数字
            // 含有小数点
            if([self.mTextNumberFiled.text containsString:@"."]){
                NSRange ran = [self.mTextNumberFiled.text rangeOfString:@"."];
                if (self.mTextNumberFiled.text.length - ran.location <= 2) {
                    NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
                    [self.mTextNumberFiled insertText:text];
                }
            }else{
                NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
                [self.mTextNumberFiled insertText:text];
            }
            
            
        }
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
