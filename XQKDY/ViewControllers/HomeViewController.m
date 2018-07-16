//
//  HomeViewController.m
//  XQKDY
//
//  Created by 张正浩 on 2017/4/26.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImageView+WebCache.h"
#import "SLSlideMenu.h"
#import "CustomQRCode.h"
#import "RightView.h"
#import <ShareSDK/ShareSDK.h>
#import "iflyMSC/IFlyMSC.h"
#import "ISRDataHelper.h"
#import "VoiceWaveView.h"
#import <AVFoundation/AVFoundation.h>
#define kmenuViewWidth kScreenWidth > 320?kScreenWidth*3.5/5:270
#define bottomViewHeight 250
@interface HomeViewController ()<SLSlideMenuProtocol,MBProgressHUDDelegate,IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate>
{
    UIView * alphaView;
    MBProgressHUD * HUD;

    //不带界面的识别对象
    IFlySpeechRecognizer * _iFlySpeechRecognizer;
    UIView * bgView;//录音背景
    UIView * bottomView;//录音底部
    UILabel * titleLabel;//录音标题
    UILabel * describeLabel;//录音失败提示
    UIButton * turnOnBtn;//录音按钮
    
}
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) UIView *voiceWaveParentViewNew;
@property (nonatomic,strong) VoiceWaveView *voiceWaveViewNew;
@property (nonatomic,strong)NSString * barCodeStr;//头像
@property (nonatomic,strong)NSString * moneyStr;//头像
@property (nonatomic,strong)UIButton * headIamgeBtn;//头像
@property (nonatomic,strong)UILabel * nameLabel;//名字
@property (nonatomic,strong)UILabel * tipIamgeView;//标签
@property (nonatomic,strong)UILabel * phoneLabel;//电话
@property (nonatomic,strong)UIImageView * lineImageView;//分割线
@property (nonatomic,strong)UIImageView * shouquanImageView;//授权图标
@property (nonatomic,strong)UIImageView * barCodeIamgeView;//授权图标
@property (nonatomic,strong)UILabel * barLabel;//授权图标
@property (nonatomic,strong)UILabel * shouquanLabel;//授权码
@property (nonatomic,strong)UIImageView * bottomLineImageView;//底部线
@property (nonatomic,strong)UIImageView * yueiconImageView;//账户余额
@property (nonatomic,strong)UILabel * yueiconLabel;//账户余额
@property (nonatomic,strong)UILabel * moneyLabel;//账户余额
@property (nonatomic,strong)UIImageView * mimaiconImageView;//密码icon
@property (nonatomic,strong)UILabel * mimaLabel;//修改密码
@property (nonatomic,strong)UIImageView * righticonImageView;//右侧箭头
@property (nonatomic,strong)UIImageView * shezhiImageView;//密码icon
@property (nonatomic,strong)UILabel * shezhiLabel;//修改密码
@property (nonatomic,strong)UILabel * refresh;//修改密码
@property (nonatomic,strong)UIActivityIndicatorView * activityIndicatorView;//修改密码
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = RGB(42, 46, 47);
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    
    //去除导航栏分割线
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list)
        {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else
            {
                
                if ([obj isKindOfClass:[UIImageView class]])
                {
                    
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2)
                    {
                        if ([obj2 isKindOfClass:[UIImageView class]])
                        {
                            
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
    

    
    //    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"DING"] isEqualToString:@"YES"]){
        [self right:nil];
    }
//    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];
    //左侧按钮
    UIButton * leftBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,40, 40)];
    [leftBtn setImage:[UIImage imageNamed:@"icon_user_"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=homeButtonItem;
    
    //右侧按钮
    UIButton * rightBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"icon_top_more_"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
}
-(void)viewDidDisappear:(BOOL)animated{
    
    _iFlySpeechRecognizer.delegate = nil;
    _iFlySpeechRecognizer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微管家";
    
    _headView.layer.cornerRadius = 10.0f;
    _headIamgeView.layer.cornerRadius = 35.0f;
    _lineImageWidth.constant = 0.5f;
    _lineWidth.constant = 0.5f;
    _lineHeight.constant = 0.5f;
    _lineHeight1.constant = 0.5f;
    [_headIamgeView sd_setImageWithURL:[NSURL URLWithString:kpicUrl] placeholderImage:[UIImage imageNamed:@"icon"]];

    
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBtn:)];
    [_speakBtn addGestureRecognizer:longPress];

    
    [SLSlideMenu prepareSlideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuSwipeDirectionLeft slideOffset:kmenuViewWidth allowSlideMenuSwipeShow:YES allowSwipeCloseMenu:YES aboveNav:YES identifier:@"swipeLeft"];
    
    [SLSlideMenu prepareSlideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuSwipeDirectionRight slideOffset:kmenuViewWidth allowSlideMenuSwipeShow:YES allowSwipeCloseMenu:YES aboveNav:YES identifier:@"swipeRight"];
    

    // Do any additional setup after loading the view.
}
//加载首页数据
-(void)loadData
{
    _nicknameLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kUserName]];
    
    MBProgressHUD *  loadingHUD = [[MBProgressHUD alloc] initWithView:self.view];
    loadingHUD.mode = MBProgressHUDModeIndeterminate;
    loadingHUD.delegate = self;
    loadingHUD.labelFont = [UIFont systemFontOfSize:16];
    [loadingHUD show:YES];
    [self.view addSubview:loadingHUD];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kgetcountUrl];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([[json valueForKey:@"code"] intValue] == 10000) {
            _fabuLabel.text = [NSString stringWithFormat:@"发布 %@",[json valueForKey:@"data"]];
        }
        
        NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kindexcountUrl];
        NSDictionary * dic2 = @{
                                @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                };
        
        NSLog(@"~~~~~~urlString:%@",urlString2);
        NSLog(@"~~~~~~dic:%@",dic2);
        [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"~~~~~~~response:%@",response);
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if ([[json valueForKey:@"code"] intValue] == 10000) {
                
                _liulanLabel.text = [NSString stringWithFormat:@"浏览 %@",[[json valueForKey:@"data"] valueForKey:@"amountView"]];
                _goumaiLabel.text = [NSString stringWithFormat:@"购买 %@",[[json valueForKey:@"data"] valueForKey:@"amountSell"]];
                _yingshouLabel.text = [NSString stringWithFormat:@"流水 %@",[[json valueForKey:@"data"] valueForKey:@"revenue"]];
                _fenrunLabel.text = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"benefit"]];
                if ([_yingshouLabel.text isEqualToString:@"流水 <null>"]) {
                    _yingshouLabel.text = @"流水 0";
                }
                
            }
            
            NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kindexrankUrl];
            NSDictionary * dic2 = @{
                                    @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                    };
            
            NSLog(@"~~~~~~urlString:%@",urlString2);
            NSLog(@"~~~~~~dic:%@",dic2);
            [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"~~~~~~~response:%@",response);
                NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if ([[json valueForKey:@"code"] intValue] == 10000) {
                    _mingciLabel.text = [NSString stringWithFormat:@"第%@名",[[json valueForKey:@"data"] valueForKey:@"myNo"]];
                    _shangshengLabel.text = [NSString stringWithFormat:@"上升%@名",[[json valueForKey:@"data"] valueForKey:@"upNo"]];
                    
                    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_mingciLabel.text];
                    NSString * myNo = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"myNo"]];
                    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0] range:NSMakeRange(1, myNo.length)];
                    _mingciLabel.attributedText = str;

                    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:_shangshengLabel.text];
                    NSString * upNo = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"upNo"]];
                    [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0] range:NSMakeRange(2, upNo.length)];
                    _shangshengLabel.attributedText = str1;
                    _chaoguoLabel.text = [NSString stringWithFormat:@"%@%%",[[json valueForKey:@"data"] valueForKey:@"overNo"]];
                }
                
                NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kcustomerinfogetcountUrl];
                NSDictionary * dic2 = @{
                                        @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                        };
                
                NSLog(@"~~~~~~urlString:%@",urlString2);
                NSLog(@"~~~~~~dic:%@",dic2);
                [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [loadingHUD hide:YES];
                    
                    NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"~~~~~~~response:%@",response);
                    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    if ([[json valueForKey:@"code"] intValue] == 10000) {
                        _fensiLabel.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"data"]];
                        
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    [loadingHUD hide:YES];
                    HUD = [[MBProgressHUD alloc] initWithView:self.view];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.delegate = self;
                    HUD.labelText = @"服务器异常";
                    HUD.labelFont = [UIFont systemFontOfSize:16];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:2];
                    [self.view addSubview:HUD];
                }];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [loadingHUD hide:YES];
                HUD = [[MBProgressHUD alloc] initWithView:self.view];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.delegate = self;
                HUD.labelText = @"服务器异常";
                HUD.labelFont = [UIFont systemFontOfSize:16];
                [HUD show:YES];
                [HUD hide:YES afterDelay:2];
                [self.view addSubview:HUD];
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [loadingHUD hide:YES];
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText = @"服务器异常";
            HUD.labelFont = [UIFont systemFontOfSize:16];
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            [self.view addSubview:HUD];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [loadingHUD hide:YES];
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"服务器异常";
        HUD.labelFont = [UIFont systemFontOfSize:16];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        [self.view addSubview:HUD];
    }];
}

-(void)left:(UIButton *)sender
{
    [SLSlideMenu slideMenuWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) delegate:self direction:SLSlideMenuDirectionLeft slideOffset:kmenuViewWidth allowSwipeCloseMenu:YES aboveNav:YES identifier:@"left"];
}

//侧滑布局
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    NSLog(@"identifier:%@",slideMenu.identifier);
    // ** 如果一个方向只有一个弹窗可根据direction区分
    if (slideMenu.direction == SLSlideMenuDirectionTop) {
        
    }
    
    if (slideMenu.direction == SLSlideMenuDirectionRight) {
        
        
        RightView * rightView =  [[[NSBundle mainBundle] loadNibNamed:@"RightView" owner:self options:nil] lastObject];
        rightView.frame = CGRectMake(0, 0, kmenuViewWidth,kScreenHeight);
        [rightView.searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.zitiBtn addTarget:self action:@selector(ziti:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.daichuliBtn addTarget:self action:@selector(daichuli:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.jiaojieBtn addTarget:self action:@selector(jiaojie:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.mendianBtn addTarget:self action:@selector(mendian:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.pickupBtn addTarget:self action:@selector(qianshou:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.tongjiBtn addTarget:self action:@selector(tongji:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.yichangBtn addTarget:self action:@selector(yichangqianshou:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.dingBtn addTarget:self action:@selector(ding:) forControlEvents:UIControlEventTouchUpInside];
        [rightView.callBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"DING"] isEqualToString:@"YES"]){
            [rightView.dingBtn setSelected:YES];
        }
        [menuView addSubview:rightView];
        
    }
    
    if (slideMenu.direction == SLSlideMenuDirectionLeft) {
        
        NSString * width = [NSString stringWithFormat:@"%.2f",kmenuViewWidth];
        NSString * firstName = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        _headIamgeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 64, 70, 70)];
        [_headIamgeBtn setBackgroundColor:kGlobalBg];
        [_headIamgeBtn setTitle:[firstName substringToIndex:1] forState:0];
        _headIamgeBtn.layer.cornerRadius = _headIamgeBtn.width/2;
        _headIamgeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_headIamgeBtn setTitleColor:[UIColor whiteColor] forState:0];
        [menuView addSubview:_headIamgeBtn];
        
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headIamgeBtn.right + 10 ,_headIamgeBtn.top + 13,100,20)];
        _nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = RGB(51, 51, 51);
        [menuView addSubview:_nameLabel];

        
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left ,_nameLabel.bottom + 5,170,20)];
        _phoneLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:kphoneNum];
        _phoneLabel.layer.cornerRadius = 5.0f;
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor lightGrayColor];
        [menuView addSubview:_phoneLabel];
        
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 ,_headIamgeBtn.bottom + 40,kmenuViewWidth,0.5)];
        _lineImageView.backgroundColor = RGB(230, 230 ,230);
        [menuView addSubview:_lineImageView];
        
        for (int i = 0; i < 3; i ++) {
            _bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 ,_lineImageView.bottom + 50*(i + 1),kmenuViewWidth,0.5)];
            _bottomLineImageView.backgroundColor = RGB(230, 230, 230);
            [menuView addSubview:_bottomLineImageView];
        }
        
        NSArray * titleArr= @[@"导师",@"掌柜",@"钱包"];
        NSArray * imageArr= @[@"icon_teacher_",@"icon_zhanggui_",@"icon_wallet_"];
        for (int i = 0; i < 3; i ++) {
            _yueiconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,_lineImageView.bottom + 50*i + 15,20,20)];
            _yueiconImageView.image = [UIImage imageNamed:imageArr[i]];
            [menuView addSubview:_yueiconImageView];
            
            _shouquanLabel = [[UILabel alloc] initWithFrame:CGRectMake(_yueiconImageView.right + 10 ,_yueiconImageView.top,200,20)];
            _shouquanLabel.text = titleArr[i];
            _shouquanLabel.textColor = RGB(51, 51, 51);
            _shouquanLabel.font = [UIFont systemFontOfSize:15];
            [menuView addSubview:_shouquanLabel];
            
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0,_lineImageView.bottom + 50*i, [width floatValue], 50)];
            btn.tag = 99+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [menuView addSubview:btn];
            
            if (i < 3) {
                _righticonImageView = [[UIImageView alloc] initWithFrame:CGRectMake([width floatValue] - 20,_lineImageView.bottom + 50*i + 15,10,20)];
                _righticonImageView.image = [UIImage imageNamed:@"icon_next_"];
                [menuView addSubview:_righticonImageView];
            }
            
        }
        
        UIImageView * midView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _bottomLineImageView.bottom, kmenuViewWidth, 20)];
        midView.backgroundColor = RGB(240, 240, 240);
        [menuView addSubview:midView];
        
        NSArray * titleArr1= @[@"邀请好友",@"意见反馈",@"设置"];
        NSArray * imageArr1 = @[@"icon_share_",@"icon_message_",@"icon_setting_-1"];
        for (int i = 0; i < 3; i ++) {
            _yueiconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,_bottomLineImageView.bottom + 50*i + 40,20,20)];
            _yueiconImageView.image = [UIImage imageNamed:imageArr1[i]];
            [menuView addSubview:_yueiconImageView];
            
            _shouquanLabel = [[UILabel alloc] initWithFrame:CGRectMake(_yueiconImageView.right + 10 ,_yueiconImageView.top,200,20)];
            _shouquanLabel.text = titleArr1[i];
            _shouquanLabel.textColor = RGB(51, 51, 51);
            _shouquanLabel.font = [UIFont systemFontOfSize:15];
            [menuView addSubview:_shouquanLabel];
            
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0,_shouquanLabel.top - 20, [width floatValue], 50)];
            btn.tag = 99+3+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [menuView addSubview:btn];
            
            _righticonImageView = [[UIImageView alloc] initWithFrame:CGRectMake([width floatValue] - 20,_yueiconImageView.top,10,20)];
            _righticonImageView.image = [UIImage imageNamed:@"icon_next_"];
            [menuView addSubview:_righticonImageView];
            
            UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 ,_righticonImageView.bottom + 10,kmenuViewWidth,0.5)];
            lineImageView.backgroundColor = RGB(230, 230, 230);
            [menuView addSubview:lineImageView];
            
        }
        
    }
    
    if (slideMenu.direction == SLSlideMenuDirectionBottom) {
        
    }
    
    
    // ** 如果一个方向有多个弹窗，可设置identifier来区分
    if ([slideMenu.identifier isEqualToString:@"right"]) {
        menuView.backgroundColor = [UIColor whiteColor];
    }
    if ([slideMenu.identifier isEqualToString:@"right1"]) {
        menuView.backgroundColor = [UIColor greenColor];
    }
    if ([slideMenu.identifier isEqualToString:@"swipeRight"]) {
        menuView.backgroundColor = [UIColor whiteColor];
    }
}


//右侧滑ding在首页
- (void)ding:(UIButton *)sender
{
    if (sender.isSelected == NO) {
        [sender setSelected:YES];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"DING"];
    }
    else{
        [sender setSelected:NO];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"DING"];
    }
}
//右侧查询
- (void)search:(UIButton *)sender
{
    [self dismissMenuView];
   
}
//右侧自提
- (void)ziti:(UIButton *)sender
{
    [self dismissMenuView];
    
}
//右侧待处理
- (void)daichuli:(UIButton *)sender
{
    [self dismissMenuView];
    
}
//右侧交接
- (void)jiaojie:(UIButton *)sender
{
    [self dismissMenuView];
    
}
//异常签收
- (void)yichangqianshou:(UIButton *)sender
{
    [self dismissMenuView];
    
}
//右侧统计
- (void)tongji:(UIButton *)sender
{
    [self dismissMenuView];
   
}
//右侧签收
- (void)qianshou:(UIButton *)sender
{
    [self dismissMenuView];
    
}
//右侧门店
- (void)mendian:(UIButton *)sender
{
    [self dismissMenuView];
   
}

//点击侧滑按钮
- (void)btnClick:(UIButton *)sender{
    NSLog(@"btnClick");
    if ((sender.tag - 99) == 0) {
        
       
    }
    else if ((sender.tag - 99) == 1) {
        
      
    }
    else if ((sender.tag - 99) == 2) {
        
        
    }
    else if ((sender.tag - 99) == 3) {
        
        //邀请好友
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@""
                                         images:[UIImage imageNamed:@"邀请好友"]
                                            url:nil
                                          title:@""
                                           type:SSDKContentTypeImage];
        
        [shareParams SSDKEnableUseClientShare];
        
        [ShareSDK share:SSDKPlatformTypeWechat parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
        }];
        
    }
    else if ((sender.tag - 99) == 4) {
  
      
    }
    
    else if ((sender.tag - 99) == 5) {


    }
          [self dismissMenuView];
    
    
}
//侧滑消失
-(void)dismissMenuView
{
    for (UIView * view in self.navigationController.view.subviews) {
        if (view.tag == 1343) {
            [view removeFromSuperview];
        }
    }
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 1234) {
            [view removeFromSuperview];
        }
    }
}
- (void)resetDefaults {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSDictionary* dict = [defs dictionaryRepresentation];
    for(id key in dict)
    {[defs removeObjectForKey:key];
    }
    [defs synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//打电话
- (IBAction)call:(UIButton *)sender {
    [self dismissMenuView];
   
}
//右侧侧滑
- (IBAction)right:(UIButton *)sender {
    
    [SLSlideMenu slideMenuWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) delegate:self direction:SLSlideMenuDirectionRight slideOffset:kmenuViewWidth allowSwipeCloseMenu:YES aboveNav:YES identifier:@"right"];
    
}
//粉丝按钮
- (IBAction)star:(UIButton *)sender {
   
}
//微书按钮
- (IBAction)webook:(UIButton *)sender {
   
}



/**
 长按说话

 @param gestureRecognizer 手势
 */
-(void)longPressBtn:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        [turnOnBtn setSelected:YES];
        //长按事件开始"
        //do something
        [self speechRecognize];
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = RGBA(0, 0, 0, 0.8);
        [self.navigationController.view addSubview:bgView];
        
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - bottomViewHeight, kScreenWidth, bottomViewHeight)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:bottomView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 20)];
        titleLabel.text = @"正在聆听中";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        [bottomView addSubview:titleLabel];
        
        
        describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + 30, kScreenWidth, 60)];
        describeLabel.text = @"报 号 码\n\n找 粉 丝";
        describeLabel.numberOfLines = 0;
        describeLabel.textAlignment = NSTextAlignmentCenter;
        describeLabel.font = [UIFont systemFontOfSize:15];
        describeLabel.textColor = RGB(120, 120, 120);
        [describeLabel setHidden:YES];
        [bottomView addSubview:describeLabel];
        
        UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 10, 30, 30)];
        [cancelBtn setImage:[UIImage imageNamed:@"icon_delete_"] forState:0];
        [cancelBtn addTarget:self action:@selector(dismissBottomView) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:cancelBtn];
        
        self.voiceWaveViewNew.frame = CGRectMake(0, 100, kScreenWidth, 100);
        [self.voiceWaveViewNew showInParentView:bottomView];
        [self.voiceWaveViewNew startVoiceWave];
        
        
        turnOnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, bottomView.height - 60, kScreenWidth - 40, 40)];
        turnOnBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        turnOnBtn.layer.cornerRadius = 20.0f;
        [turnOnBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_voice_selected_"] forState:UIControlStateSelected];
        [turnOnBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_voice_default_"] forState:0];
        [turnOnBtn setTitle:@"松开 搜索" forState:UIControlStateSelected];
        [turnOnBtn setTitle:@"按住说话" forState:0];
        [turnOnBtn setImage:[UIImage imageNamed:@"icon_voice_default_"] forState:0];
        [turnOnBtn setImage:[UIImage imageNamed:@"icon_voice_selected_"] forState:UIControlStateSelected];
        [turnOnBtn setTitleColor:kGlobalBg forState:0];
        [turnOnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        turnOnBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [turnOnBtn setSelected:YES];
        [bottomView addSubview:turnOnBtn];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouch:)];
        [turnOnBtn addGestureRecognizer:longPress];
        
    }
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        [turnOnBtn setSelected:NO];
        //长按事件结束
        //do something
        [_iFlySpeechRecognizer stopListening];
    }
}


-(void)longTouch:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        [turnOnBtn setSelected:YES];
        //长按事件开始"
        //do something
        [self speechRecognize];
        [self.voiceWaveViewNew showInParentView:bottomView];
        [_voiceWaveViewNew startVoiceWave];
        [describeLabel setHidden:YES];
        titleLabel.text = @"正在聆听中";
      }
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        [turnOnBtn setSelected:NO];
        //长按事件结束
        //do something
        [_iFlySpeechRecognizer stopListening];
    }
}


- (VoiceWaveView *)voiceWaveViewNew{
    if (!_voiceWaveViewNew) {
        self.voiceWaveViewNew = [[VoiceWaveView alloc] init];
        [_voiceWaveViewNew setVoiceWaveNumber:3];
    }
    return _voiceWaveViewNew;
}

//听写
-(void)speechRecognize{
    //1.创建语音听写对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance]; //设置听写模式
    _iFlySpeechRecognizer.delegate = self;
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //2.设置听写参数
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //3.启动识别服务
    [_iFlySpeechRecognizer startListening];//官网文档里有错误，不是start
}


#pragma mark - IFlySpeechRecognizerDelegate
//没有界面时的语音听写
//识别结果返回代理
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    NSMutableString *result = [[NSMutableString alloc] init];
    if (results.count > 0 && isLast == NO) {
        NSDictionary *dic = [results objectAtIndex:0];
        for (NSString *key in dic)
        {
            [result appendFormat:@"%@",key];//合并结果
        }
       
        NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
         NSLog(@"识别成功:%@",resultFromJson);
        if (resultFromJson.length == 11) {
            [self dismissBottomView];
        
            
        }
        else{
            
            [self listenFiald];
        }

    }
    else
    {
        [self listenFiald];
    }
}

//识别失败
- (void)listenFiald
{
    titleLabel.text = @"没听清,您说的电话号码。。。";
    [_voiceWaveViewNew removeFromParent];
    [describeLabel setHidden:NO];
    
}
//移除录音界面
-(void)dismissBottomView
{
    [bgView removeFromSuperview];
    [_voiceWaveViewNew removeFromParent];
    
}
/**
 音量回调函数
 volume 0－30
 ****/
- (void)onVolumeChanged:(int)volume {
    NSString * vol = [NSString stringWithFormat:@"%.2f",(float)volume/30];
    NSLog(@"%@",vol);
    [_voiceWaveViewNew changeVolume:[vol floatValue]];
  
}
/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech {

    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MicrophoneTurnOn" ofType:@"mp3"]] error:nil];
    [_audioPlayer play];
}

/**
 停止录音回调
 ****/
- (void) onEndOfSpeech {

    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MicrophoneTurnOff" ofType:@"mp3"]] error:nil];
    [_audioPlayer play];
    [_voiceWaveViewNew changeVolume:0.1];
}


@end
