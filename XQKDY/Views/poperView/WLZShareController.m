//
//  WLZShareController.m
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import "WLZShareController.h"
#import "WLZShareItem.h"
#import "IQKeyboardManager.h"
#import "PlaceView.h"
//static CGFloat itemWidth = 80.0f;
static CGFloat itemHeight = 50.0f;
static NSInteger itemCount = 4.0f;

//子元素的边距
static CGFloat boardWidth = 10.0f;
//子元素的边距
static CGFloat boardHeight = 10.0f;

//距离父view的边距 x
static CGFloat marginX = 10.0f;
//距离父view的边距 y
static CGFloat marginY = 40.0f;

//背景alpha值
static CGFloat viewAlpha =  0.6f;


//底部BT的高度
static CGFloat endBtHeight = 0.0f;
@interface WLZShareController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIButton * typeBtn;
    UIButton * typeConfirmBtn;
    UIButton * kgBtn;
    UIButton * kgConfirmBtn;
    PlaceView * packView;
    NSString * zhuanjiStr;
    NSString * noticeStr;

}
@property(nonatomic,strong)NSMutableArray *array_items;
@property(nonatomic,strong)NSMutableArray * typeArr;
@property(nonatomic,strong)NSMutableArray * kgArr;
@property(nonatomic, strong)UITextField * type;
@property(nonatomic, strong)UITextField * kg;
@property(nonatomic, strong)UIButton * confirmBtn;
@property(nonatomic, strong)UIView * typeView;
@property(nonatomic, strong)UIView * kgView;
@property(nonatomic,strong) UIView *darkView;
@property(nonatomic, retain)NSString * tips1;
@property(nonatomic, retain)NSString * tips;


@end

@implementation WLZShareController

-(void)viewWillAppear:(BOOL)animated
{
    //管理键盘
//    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
//    manager.enable = NO;
//    manager.shouldResignOnTouchOutside = NO;
//    manager.shouldToolbarUsesTextFieldTintColor = NO;
//    manager.enableAutoToolbar = NO;
    
    //注册键盘出现与隐藏时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboadWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];

}

//键盘出现时候调用的事件
-(void) keyboadWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    CGFloat offY = (kScreenHeight-keyboardSize.height)- 400;//屏幕总高度-键盘高度-UITextField高度
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
//    _type.frame = CGRectMake(35, offY, 250, 35);//UITextField位置的y坐标移动到offY
    if (_isShunfeng) {
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, kScreenHeight-400, _contentView.frame.size.width, 400);
    }
    else{
    _contentView.frame = CGRectMake(_contentView.frame.origin.x, offY, _contentView.frame.size.width, 400);
    }
    [UIView commitAnimations];//开始动画效果
    
}
//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
//    _type.frame = CGRectMake(35, 230, 250, 35);//UITextField位置复原
    if (_isShunfeng) {
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, kScreenHeight-320, _contentView.frame.size.width, 320);

    }
    else
    {
     _contentView.frame = CGRectMake(_contentView.frame.origin.x, kScreenHeight-400, _contentView.frame.size.width, 400);
    }
    [UIView commitAnimations];
}
//隐藏键盘方法
-(void)hideKeyboard{
    [_type resignFirstResponder];
}
#pragma mark -
#pragma mark UITextFieldDelegate
//开始编辑：
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//点击return按钮所做的动作：
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//取消第一响应
    return YES;
}

//编辑完成：
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
//    //管理键盘
//    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = YES;
}

-(void)viewTapped:(UITapGestureRecognizer*)tap
{
    [_type resignFirstResponder];
}

- (instancetype)init
{
    self = [super init];
    if ( self) {
        self.view.frame =[UIScreen mainScreen].bounds;
        
        [self setUpViews];
        _typeArr = [NSMutableArray arrayWithObjects:@"文件",@"物品",@"数码产品",@"易碎品",@"日用品",@"其他", nil];
        _kgArr = [NSMutableArray arrayWithObjects:@"1kg",@"2kg",@"3kg",@"4kg",@"5kg",@"其他", nil];
        _tips1 = @"";
        _tips  = @"";
    }
    return self;
}

- (NSMutableArray *)array_items
{
    if (!_array_items) {
        _array_items =[NSMutableArray array];
    }
    return _array_items;
}

- (void)addItem:(NSString *)title icon:(NSString *)icon block:(void (^)(WLZBlockButton *))block
{
    
    WLZShareItem *item = [[WLZShareItem alloc]init];
    item.logoImageView.image = [UIImage imageNamed:icon];
    item.titleLabel.text = title;
    [self.contentView addSubview:item];
    [self.array_items addObject:item];
    [item.itemButton setBlock:^(WLZBlockButton *button){
        block(button);
    
        
        if ([item.titleLabel.text isEqualToString:@"其他类型"]) {
            [self othertype];
        }
        else if ([item.titleLabel.text isEqualToString:@"其他重量"]) {
            [self otherkg];
        }
        else
        {
            [self removeView];

        }

    }];
  
}
-(void)othertype
{
    _contentView.frame = CGRectMake(_contentView.frame.origin.x, kScreenHeight-250, _contentView.frame.size.width, 250);
    _type = [[UITextField alloc] initWithFrame:CGRectMake(10,170, kScreenWidth-100, 30)];
    _type.borderStyle = UITextBorderStyleLine;
    _type.delegate = self;//设置代理
    _type.placeholder = @"请输入类型";
    [_contentView addSubview:_type];
    
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 170, 70, 30)];
    [_confirmBtn setBackgroundColor:RGB(252, 141, 13)];
    _confirmBtn.layer.cornerRadius = 5.0f;
    [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_contentView addSubview:_confirmBtn];
    
}
-(void)otherkg
{
    _contentView.frame = CGRectMake(_contentView.frame.origin.x, kScreenHeight-250, _contentView.frame.size.width, 250);
    _kg = [[UITextField alloc] initWithFrame:CGRectMake(10,170, kScreenWidth-100, 30)];
    _kg.borderStyle = UITextBorderStyleLine;
    _kg.delegate = self;//设置代理
    _kg.placeholder = @"请输入重量";
    [_contentView addSubview:_kg];
    
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 170, 70, 30)];
    [_confirmBtn setBackgroundColor:RGB(252, 141, 13)];
    _confirmBtn.layer.cornerRadius = 5.0f;
    [_confirmBtn addTarget:self action:@selector(confirm1) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_contentView addSubview:_confirmBtn];
    
}
-(void)confirm
{
    [self removeView];
}
-(void)confirm1
{
//    NSDictionary * dic  = @{
//                            @"kg":_kg.text,
//                            };
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseKg" object:nil userInfo:dic];
    if ([_kg.text intValue] > 0) {

    [kgConfirmBtn setTitle:[NSString stringWithFormat:@"%@kg",_kg.text] forState:0];
        
    [self tapTheDarkView];
    }
    else
    {
        kShowAlertView(@"提示", @"请输入完整信息", @"确定");
    }
   
    
}
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 250)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
        
        
    }
    return _contentView;
}

- (void)setUpViews
{
    _darkView = [[UIView alloc] initWithFrame:self.view.frame];
    _darkView.backgroundColor = [UIColor blackColor];
    _darkView.userInteractionEnabled=YES;
    _darkView.alpha = viewAlpha;
    [self.view addSubview:_darkView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheDarkView)];
    [_darkView addGestureRecognizer:tap];

}

- (void)tapTheDarkView
{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, _contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeView];
    }];
}

- (void)removeView
{
    if (typeConfirmBtn.titleLabel.text.length > 0 && kgConfirmBtn.titleLabel.text.length > 0) {

    NSDictionary * dic = @{
                           @"type":typeConfirmBtn.titleLabel.text,
                           @"kg":kgConfirmBtn.titleLabel.text,
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TypeKg" object:nil userInfo:dic];
  
    }
    for (UIView *views in self.view.subviews) {
        [views removeFromSuperview];
    }
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)show
{
    CGFloat itemWidth =(self.view.frame.size.width-((itemCount-1)*boardWidth)-(marginX*2))/itemCount;
    CGFloat height = 0;
    CGFloat rows = _array_items.count/itemCount +( (_array_items.count%itemCount) != 0 ?1:0);
    height = rows* itemHeight + rows*marginY;
//    for (int i=0; i<_array_items.count; i++) {
//        CGFloat x = (i%itemCount)*(itemWidth+boardWidth)+marginX;
//        CGFloat y = floor(i/itemCount)*(itemHeight+boardHeight)+marginY;
//        WLZShareItem *item =(WLZShareItem *) [_array_items objectAtIndex:i];
//        item.frame = CGRectMake(x, y, itemWidth, itemHeight);
//    }
//
 
    [UIView animateWithDuration:0.3 animations:^{

        if (_isNotice) {
            _contentView.frame = CGRectMake(0, self.view.frame.size.height - 400, self.view.frame.size.width,400);
            
            packView =  [[[NSBundle mainBundle] loadNibNamed:@"PlaceView" owner:self options:nil] lastObject];
            packView.ohterArr = [NSMutableArray new];
            packView.ohterArr = _otherArr;
            packView.frame = CGRectMake(0, 0, kScreenWidth,400);
            [packView.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];

            noticeStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"Notice"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"Notice"]:@"";
            //            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEnd:) name:@"textViewEnd" object:nil];
            [_contentView addSubview:packView];
        }
        else
        {
            [self showTypeView];
            _contentView.frame = CGRectMake(0, self.view.frame.size.height-height-endBtHeight, self.view.frame.size.width, height+endBtHeight);
        }
    }];
    
    [_contentView addSubview:[self cancelBt:_contentView.frame.size.height-50]];
    
    if (_isType) {

    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 150, 5, 140, 40)];
    [cancelBt setTitle:@"查看违禁物品>" forState:UIControlStateNormal];
    cancelBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancelBt addTarget:self action:@selector(weijinping:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelBt.titleLabel.font=[UIFont systemFontOfSize:13];
    cancelBt.backgroundColor=[UIColor clearColor];
    [_contentView addSubview:cancelBt];
        
    }
    

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    
    
}
-(void)textChange:(NSNotification *)sender
{
    _tips1 = sender.userInfo[@"text"];
    noticeStr = _tips1;
    NSLog(@"~~~~~~_tips1:%@", noticeStr);

}

//快递员留言
-(void)pack:(UIButton *)sender
{
    NSDictionary * dic;


    switch (sender.tag) {
        case 100:
            dic = @{
                    @"notice":noticeStr,
                    };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LiuYan" object:nil userInfo:dic];

            [[NSUserDefaults standardUserDefaults] setObject:noticeStr forKey:@"Notice"];
            [self removeView];
            break;
        case 101:
            _tips = @"请带纸箱 ";
            _tips1 = [_tips1 stringByReplacingOccurrencesOfString:_tips withString:@""];
            _tips1 = [_tips1 stringByReplacingOccurrencesOfString:@"请带包装袋 " withString:@""];
            noticeStr = [NSString stringWithFormat:@"%@%@",_tips,_tips1];

            NSLog(@"~~~~~~liuyan:%@", noticeStr);
            break;
        case 102:
            _tips = @"请带包装袋 ";
            _tips1 = [_tips1 stringByReplacingOccurrencesOfString:_tips withString:@""];
            _tips1 = [_tips1 stringByReplacingOccurrencesOfString:@"请带纸箱 " withString:@""];
            noticeStr = [NSString stringWithFormat:@"%@%@",_tips,_tips1];

            NSLog(@"~~~~~~liuyan:%@", noticeStr);
            break;
            
        default:
            break;
    }
    
  
}
-(void)zhuanji:(UIButton *)sender{

    if (sender.tag == 1000) {

         zhuanjiStr = @"客户转寄";
    }
    else
    {

         zhuanjiStr = @"韵达未取";
    }
}
-(void)confirm2:(UIButton *)sender
{
    NSDictionary * dic = @{
                           @"zhuanji":zhuanjiStr,
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZhuanJi" object:nil userInfo:dic];
    [self tapTheDarkView];
}
- (void)textFieldChanged:(id)sender
{

}
-(void)baojia:(UIButton *)sender
{
   
}
- (WLZBlockButton * )cancelBt:(CGFloat) height
{

    WLZBlockButton * cancelBt = [[WLZBlockButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    [cancelBt setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [cancelBt setBlock:^(WLZBlockButton *button){
        [self tapTheDarkView];
    }];
    [cancelBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBt.titleLabel.font=[UIFont systemFontOfSize:13];
    cancelBt.backgroundColor=[UIColor clearColor];
//    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, 1)];
//    line.backgroundColor=[UIColor blackColor];
//    [cancelBt addSubview:line];
    return cancelBt;
}
-(void)weijinping:(UIButton *)sender
{
    [self removeView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiJing" object:nil];
}


-(void)typeChoose:(UIButton *)sender
{
    if (sender.tag == 5) {
      
        _contentView.frame = CGRectMake(0, kScreenHeight-250, _contentView.frame.size.width, 250);
        
        [_type removeFromSuperview];
        _type = [[UITextField alloc] initWithFrame:CGRectMake(20,180, kScreenWidth-130, 30)];
        _type.borderStyle = UITextBorderStyleRoundedRect;
        _type.delegate = self;//设置代理
        _type.placeholder = @"请输入类型";
        [_contentView addSubview:_type];
        
        [_confirmBtn removeFromSuperview];
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 180, 70, 30)];
        [_confirmBtn setBackgroundColor:RGB(252, 141, 13)];
        _confirmBtn.layer.cornerRadius = 5.0f;
        [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_contentView addSubview:_confirmBtn];

 
    }
    else
    {
        [typeConfirmBtn setTitle:_typeArr[sender.tag] forState:0];

        [self showKgView];

    }
}
-(void)kgchoose:(UIButton *)sender
{
    if (sender.tag == 5) {
        
        _contentView.frame = CGRectMake(0, kScreenHeight-260, _contentView.frame.size.width, 260);
        
        [_type removeFromSuperview];
        _kg = [[UITextField alloc] initWithFrame:CGRectMake(20,210, kScreenWidth-130, 30)];
        _kg.borderStyle = UITextBorderStyleRoundedRect;
        _kg.delegate = self;//设置代理
        _kg.placeholder = @"请输入重量";
        _kg.keyboardType = UIKeyboardTypeDecimalPad;
        [_contentView addSubview:_kg];
        
        [_confirmBtn removeFromSuperview];
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 210, 70, 30)];
        [_confirmBtn setBackgroundColor:RGB(252, 141, 13)];
        _confirmBtn.layer.cornerRadius = 5.0f;
        [_confirmBtn addTarget:self action:@selector(confirm1) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_contentView addSubview:_confirmBtn];

      
    }
    else
    {
        [kgConfirmBtn setTitle:_kgArr[sender.tag] forState:0];
        [self removeView];

    }
}
-(void)showKgView
{
    [_type removeFromSuperview];
    [_confirmBtn removeFromSuperview];
    
    _contentView.frame = CGRectMake(0, kScreenHeight-230, _contentView.frame.size.width, 230);
    
    _typeView.frame = CGRectMake(0, 40, kScreenWidth, 40);
    _kgView = [[UIView alloc] initWithFrame:CGRectMake(0, _typeView.bottom, kScreenWidth, 150)];
    _kgView.backgroundColor = [UIColor whiteColor];
    [_kgView removeFromSuperview];
    [_contentView addSubview:_kgView];
    
    UILabel * typeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    typeLab.text= @"物品重量";
    typeLab.textColor = [UIColor lightGrayColor];
    [_kgView addSubview:typeLab];
    
    UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth - 20, 1)];
    line.backgroundColor = RGB(230, 230, 230);
    [_kgView addSubview:line];
    

    
    kgConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100,5,100, 20)];
    [kgConfirmBtn setTitleColor:[UIColor blackColor] forState:0];
    [_kgView addSubview:kgConfirmBtn];
    
    
    for (int i = 0 ; i < 6; i ++) {
        kgBtn = [[UIButton alloc]initWithFrame:CGRectMake((i-3)<0?20+((kScreenWidth - 80)/3 + 20)*i:20+((kScreenWidth - 80)/3 + 20)*(i-3),(i-3)<0?40:90, (kScreenWidth - 80)/3, 30)];
        kgBtn.tag = i;
        [kgBtn setTitle:_kgArr[i] forState:0];
        kgBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [kgBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        [kgBtn setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:0];
        [kgBtn addTarget:self action:@selector(kgchoose:) forControlEvents:UIControlEventTouchUpInside];
        [kgBtn removeFromSuperview];
        [_kgView addSubview:kgBtn];
    }

}
-(void)showTypeView
{

    _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 150)];
    _typeView.backgroundColor = [UIColor whiteColor];
    [_typeView removeFromSuperview];
    [_contentView addSubview:_typeView];
    
  
    
    UILabel * typeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    typeLab.text= @"物品名称";
    typeLab.textColor = [UIColor lightGrayColor];
    [typeLab removeFromSuperview];
    [_typeView addSubview:typeLab];
    
    typeConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100,5,100, 20)];
    [typeConfirmBtn addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
    [typeConfirmBtn setTitleColor:[UIColor blackColor] forState:0];
    [typeConfirmBtn removeFromSuperview];
    [_typeView addSubview:typeConfirmBtn];

    UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth - 20, 1)];
    line.backgroundColor = RGB(230, 230, 230);
    [_typeView addSubview:line];
    

    
    for (int i = 0 ; i < 6; i ++) {
        typeBtn = [[UIButton alloc]initWithFrame:CGRectMake((i-3)<0?20+((kScreenWidth - 80)/3 + 20)*i:20+((kScreenWidth - 80)/3 + 20)*(i-3),(i-3)<0?40:90, (kScreenWidth - 80)/3, 30)];
        typeBtn.tag = i;
        [typeBtn setTitle:_typeArr[i] forState:0];
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [typeBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:0];
        [typeBtn addTarget:self action:@selector(typeChoose:) forControlEvents:UIControlEventTouchUpInside];
        [typeBtn removeFromSuperview];
        [_typeView addSubview:typeBtn];
    }
    

}
-(void)chooseType:(UIButton *)sender
{
   [_kgView removeFromSuperview];
   [_type removeFromSuperview];
   _typeView.frame = CGRectMake(0, 40, kScreenWidth, 150);
   _contentView.frame = CGRectMake(0, kScreenHeight-200, _contentView.frame.size.width, 200);
   [_kg removeFromSuperview];
   [_confirmBtn removeFromSuperview];
    
    
}
@end
