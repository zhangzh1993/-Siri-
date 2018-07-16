//
//  PlaceView.m
//  XQKDY
//
//  Created by 张正浩 on 2017/4/25.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "PlaceView.h"
#import "SKTagView.h"
#import "HexColors.h"
#import <CoreLocation/CoreLocation.h>

@interface PlaceView() <CLLocationManagerDelegate>{
    
    NSString * _Strlatitude;//经度
    NSString * _Strlongitude;//纬度
    NSString * _nowTime;     //时间
}
/* 位置管理者 */
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation PlaceView

- (void)awakeFromNib {
    [super awakeFromNib];
    _StoreBtn.layer.cornerRadius = 5.0f;
    _confirmBtn.layer.cornerRadius = 20.0f;
    [self loadStoreData];
    [self loadTagData];
    [self loadOtherData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTagViewHeight:) name:@"OtherTagViewHeight" object:nil];
    
    // Initialization code
}
-(void)getTagViewHeight:(NSNotification *)sender
{
    NSString * openHeight = sender.userInfo[@"height"];
    NSString * isother = sender.userInfo[@"isother"];
    
    if ([isother isEqualToString:@"isStore"]) {
        _storeViewHeight.constant = openHeight.floatValue;
    }
    else if ([isother isEqualToString:@"isOther"]) {
        _otherViewHeight.constant = openHeight.floatValue;
    }
    else
    {
        _guiziViewHeight.constant = openHeight.floatValue;
    }
}
#pragma mark - Private
- (void)dl_setupTagView {


}
#pragma mark - Private
- (void)otherTagView {

    self.othertagView = ({
        
        SKTagView *view = [SKTagView new];
        view.isOther = @"1";
        view.tag = 113;
        view.backgroundColor = [UIColor whiteColor];
        view.padding = UIEdgeInsetsMake(0, 0, 0, 0);
        view.interitemSpacing = 10;
        view.lineSpacing = 10;
        view.didTapTagAtIndex = ^(NSUInteger index){

            if (index == _ohterArr.count -1) {
                //分类名称
                UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
                _bgView = [[UIView alloc] initWithFrame:window.bounds];
                _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
                [window addSubview:_bgView];
                
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:_bgView.frame];
                imageView.userInteractionEnabled = YES;
                // 双击的 Recognizer
                UITapGestureRecognizer* Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                Recognizer.numberOfTapsRequired = 1; // 双击
                //关键语句，给self.view添加一个手势监测；
                [imageView addGestureRecognizer:Recognizer];
                [_bgView addSubview:imageView];
                
                
                _publishView = [[UIView alloc] init];
                _publishView.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
                _publishView.clipsToBounds = YES;
                _publishView.layer.cornerRadius = 10.0f;
                _publishView.backgroundColor = [UIColor whiteColor];
                [_bgView addSubview:_publishView];
                
                titleLab  = [[UILabel alloc] initWithFrame:CGRectMake(15, 20,kScreenWidth - 70, 20)];
                titleLab.text = @"新增标签";
                titleLab.textAlignment = NSTextAlignmentCenter;
                titleLab.font = [UIFont systemFontOfSize:14];
                [_publishView addSubview:titleLab];
                
                
                classifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 75 - 20, kScreenWidth - 70, 40)];
                classifyTextField.backgroundColor = RGB(230, 230, 230);
                classifyTextField.layer.cornerRadius = 5.0f;
                //        classifyTextField.delegate = self;
                classifyTextField.font = [UIFont systemFontOfSize:14];
                classifyTextField.placeholder = @"请输入标签";
                [_publishView addSubview:classifyTextField];
                
                UIButton *  confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(classifyTextField.right - 60 , classifyTextField.bottom + 10, 60, 30)];
                [confirmBtn setBackgroundColor:kGlobalBg];
                confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                [confirmBtn setTitle:@"确认" forState:0];
                confirmBtn.tag = index;
                confirmBtn.layer.cornerRadius = 5.0f;
                [confirmBtn setTitleColor:[UIColor whiteColor] forState:0];
                [confirmBtn addTarget:self action:@selector(confirmAddtag:) forControlEvents:UIControlEventTouchUpInside];
                [_publishView addSubview:confirmBtn];
                
                
                [UIView animateWithDuration:0.3 animations:^{
                    _publishView.frame = CGRectMake(20, kScreenHeight/2-100, kScreenWidth-40, 150);
                }];

                
            }
            else{
                _tagStr = _ohterArr[index];

//                UINavigationController * nav = (UINavigationController *)[self getCurrentVC];
//                for (UIView * view in nav.view.subviews) {
//                    if (view.tag == 1343) {
//                        [view removeFromSuperview];
//                    }
//                }
//                for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
//                    if (view.tag == 1234) {
//                        [view removeFromSuperview];
//                    }
//                }
//                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
//                manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
//                manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
//                NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kaddlabelUrl];
//                NSDictionary * dic2 = @{
//                                        @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
//                                        @"type":@"POSITION",
//                                        @"labelname":_ohterArr[index],
//                                        @"phone":_phoneStr,
//                                        };
//                
//                NSLog(@"~~~~~~urlString:%@",urlString2);
//                NSLog(@"~~~~~~dic:%@",dic2);
//                [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                    
//                    NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//                    NSLog(@"~~~~~~~response:%@",response);
//                    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
//                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                    
//                    
//                    if ([[json valueForKey:@"code"] intValue]==10000) {
//                        MessageModelViewController * messageVC = [[MessageModelViewController alloc] init];
//                        messageVC.typeStr = @"0";
//                        messageVC.phone = _phoneStr;
//                        messageVC.labelStr = _ohterArr[index];
//                        [[self getCurrentVC] presentViewController:messageVC animated:YES completion:^{
//                            
//                        }];
//                    }
//                    
//                    
//                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    
//                    
//                }];
                
                for (UIView * view in _storetagView.subviews) {
                    if ([view isKindOfClass:[UIButton class]]) {
                        UIButton * btn = (UIButton *)view;
                        [btn setSelected:NO];
                    }
                }
                for (UIView * view in _guizitagView.subviews) {
                    if ([view isKindOfClass:[UIButton class]]) {
                        UIButton * btn = (UIButton *)view;
                        [btn setSelected:NO];
                    }
                }

            }
            
            NSLog(@"点击了:%@",_ohterArr[index]);
            
            
        };
        view.didRemoveTagAtIndex = ^(NSUInteger index){
            NSLog(@"删除了:%@",_ohterArr[index]);
        };
        view;
    });
    self.othertagView.frame = CGRectMake(0, 0, kScreenWidth -  20, 400);
    [_otherView addSubview:self.othertagView];
    
    
    self.originalButtonCount = _ohterArr.count;
    [_ohterArr enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText: text];
        tag.textColor = kGlobalBg;
        tag.slcTextColor = [UIColor whiteColor];
        [self dl_configTag:tag withIndex:idx];
        [self.othertagView addTag:tag];
    }];
}

-(void)tap:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _publishView.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
        [_bgView removeFromSuperview];
    }];
}
-(void)confirmAddtag:(UIButton *)sender
{
    if (classifyTextField.text.length > 0) {

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应

        NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,klabellibtoaddUrl];
        NSDictionary * dic2 = @{
                                @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                @"title":@"smsLabel",
                                @"labelname":classifyTextField.text,
                                };
        NSLog(@"~~~~~~dic:%@",dic2);
        [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"~~~~~~~response:%@",response);
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            if ([[json valueForKey:@"code"] intValue]==10000) {
                [UIView animateWithDuration:0.3 animations:^{
                    _publishView.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
                    [_bgView removeFromSuperview];
                }];
                SKTag *tag = [SKTag tagWithText: classifyTextField.text];
                if (_ohterArr.count == 1) {
                    [_ohterArr insertObject:classifyTextField.text atIndex:0];
                    [self.othertagView insertTag:tag atIndex:0];
                }
                else
                {
                [_ohterArr insertObject:classifyTextField.text atIndex:_ohterArr.count -2];
                [self.othertagView insertTag:tag atIndex:_ohterArr.count - 2];
                }
                [self dl_configTag:tag withIndex:self.originalButtonCount];
                [self.guizitagView insertTag:tag atIndex:_tagArr.count - 2];
                self.originalButtonCount ++ ;
                
            }
            else
            {
                HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentVC].view];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.delegate = self;
                HUD.labelText = [json valueForKey:@"msg"];
                HUD.labelFont = [UIFont systemFontOfSize:16];
                [HUD show:YES];
                [HUD hide:YES afterDelay:2];
                [[self getCurrentVC].view addSubview:HUD];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentVC].view];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText = @"服务器异常";
            HUD.labelFont = [UIFont systemFontOfSize:16];
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            [[self getCurrentVC].view addSubview:HUD];
        }];
        
    }
    else{
        kShowAlertView(@"提示", @"请输入完整参数", @"确定");
    }
    
    
    
}
-(void)dl_configTag:(SKTag *)tag withIndex:(NSUInteger)index
{
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    tag.nrmColor = RGB(220, 220, 220);
    tag.slcColor = kGlobalBg;
    tag.cornerRadius = 5;
}

- (void)requestEventAction:(UIButton *)button {
    
    [self creatGuizi];
    [self.alertView closeView];

}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
 
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadTagData
{
    _tagArr = [NSMutableArray new];
    _tagIdArr = [NSMutableArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应

    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kexpresscabinetUrl];
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
        NSMutableArray *tagsArray = [NSMutableArray new];
        if ([[json valueForKey:@"code"] intValue]==10000) {
            
            NSMutableArray *tagsArray = [NSMutableArray arrayWithArray:[json valueForKey:@"data"] ];
            
            for (int i = 0; i < tagsArray.count; i ++) {
                [_tagArr addObject: [tagsArray[i] valueForKey:@"cabName"]];
                [_tagIdArr addObject: [tagsArray[i] valueForKey:@"cabId"]];
            }


        }
        else{

        }
        [_tagArr addObject:@"   +   "];
        
        self.guizitagView = ({
            
            SKTagView *view = [SKTagView new];
            view.isOther = @"0";
            view.tag = 112;
            view.backgroundColor = [UIColor whiteColor];
            view.padding = UIEdgeInsetsMake(0, 0, 0, 0);
            view.interitemSpacing = 10;
            view.lineSpacing = 10;
            view.didTapTagAtIndex = ^(NSUInteger index){
                
                if (index == _tagArr.count -1) {
                    self.alertView = [[TCAlertView alloc] initWithFrame:CGRectMake(30, 120, [UIScreen mainScreen].bounds.size.width - 60, 220)];
                    self.alertView.backgroundColor = [UIColor whiteColor];
                    self.alertView.delegate = self;
                    self.alertView.isGuizi = @"1";
                    [self.alertView showView];
                    [self.alertView.remarkField becomeFirstResponder];
                }
                else{
                    
                    
                    
                    //                        UINavigationController * nav = (UINavigationController *)[self getCurrentVC];
                    //                        for (UIView * view in nav.view.subviews) {
                    //                            if (view.tag == 1343) {
                    //                                [view removeFromSuperview];
                    //                            }
                    //                        }
                    //                        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                    //                            if (view.tag == 1234) {
                    //                                [view removeFromSuperview];
                    //                            }
                    //                        }
                    //
                    //
                    //                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    //                        // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
                    //                        manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
                    //                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
                    //                        NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kaddlabelUrl];
                    //                        NSDictionary * dic2 = @{
                    //                                                @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                    //                                                @"type":@"POSITION",
                    //                                                @"labelname":_tagArr[index],
                    //                                                @"phone":_phoneStr,
                    //                                                };
                    //
                    //                        NSLog(@"~~~~~~urlString:%@",urlString2);
                    //                        NSLog(@"~~~~~~dic:%@",dic2);
                    //                        [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    //
                    //                            NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    //                            NSLog(@"~~~~~~~response:%@",response);
                    //                            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                    //                            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    //
                    //
                    //                            if ([[json valueForKey:@"code"] intValue]==10000) {
                    //
                    //                                MessageModelViewController * messageVC = [[MessageModelViewController alloc] init];
                    //                                messageVC.typeStr = @"2";
                    //                                messageVC.labelStr = _tagArr[index];
                    //                                messageVC.phone = _phoneStr;
                    //                                messageVC.cabId = _tagIdArr[index] ;
                    //                                [[self getCurrentVC] presentViewController:messageVC animated:YES completion:^{
                    //
                    //                                }];
                    //                            }
                    //
                    //
                    //                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    //
                    //
                    //                        }];
                    
                    //
                    _tagStr = _tagArr[index];
                    _cabIdStr = _tagIdArr[index];
                    for (UIView * view in _othertagView.subviews) {
                        if ([view isKindOfClass:[UIButton class]]) {
                            UIButton * btn = (UIButton *)view;
                            [btn setSelected:NO];
                        }
                    }
                    for (UIView * view in _storetagView.subviews) {
                        if ([view isKindOfClass:[UIButton class]]) {
                            UIButton * btn = (UIButton *)view;
                            [btn setSelected:NO];
                        }
                    }
                    
                }
                
                NSLog(@"点击了:%@",_tagArr[index]);
            };
            view.didRemoveTagAtIndex = ^(NSUInteger index){
                NSLog(@"删除了:%@",_tagArr[index]);
            };
            view;
        });
        self.guizitagView.frame = CGRectMake(0, 0, kScreenWidth -  20,400);
        [_guiziView addSubview:self.guizitagView];
        
        
        self.originalButtonCount = _tagArr.count;
        [_tagArr enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
            SKTag *tag = [SKTag tagWithText: text];
            if (idx < tagsArray.count) {
                tag.cbid = [tagsArray[idx] valueForKey:@"cabId"];
            }
            tag.selected = NO;
            tag.textColor = kGlobalBg;
            tag.slcTextColor = [UIColor whiteColor];
            [self dl_configTag:tag withIndex:idx];
            [self.guizitagView addTag:tag];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"服务器异常";
        HUD.labelFont = [UIFont systemFontOfSize:16];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        [[self getCurrentViewController].view addSubview:HUD];
    }];

}

-(void)loadStoreData
{
    _storeArr = [NSMutableArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    
    
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kexpressshopgetallUrl];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"status":@"ACT",
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *tagsArray = [NSMutableArray new];
        if ([[json valueForKey:@"code"] intValue]==10000) {
            
            tagsArray = [NSMutableArray arrayWithArray:[json valueForKey:@"data"] ];
            for (int i = 0; i < tagsArray.count; i ++) {
                [_storeArr addObject: [tagsArray[i] valueForKey:@"shopName"]];
            }
        }
        else{
            
        }
        
        [_storeArr addObject:@"   +   "];
        self.storetagView  = ({
            
            SKTagView *view = [SKTagView new];
            view.tag = 111;
            view.isStore = @"1";
            view.backgroundColor = [UIColor whiteColor];
            view.padding = UIEdgeInsetsMake(0, 0, 0, 0);
            view.interitemSpacing = 10;
            view.lineSpacing = 10;
            view.didTapTagAtIndex = ^(NSUInteger index){
                //                    UINavigationController * nav = (UINavigationController *)[self getCurrentVC];
                //                    for (UIView * view in nav.view.subviews) {
                //                        if (view.tag == 1343) {
                //                            [view removeFromSuperview];
                //                        }
                //                    }
                //                    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                //                        if (view.tag == 1234) {
                //                            [view removeFromSuperview];
                //                        }
                //                    }
                
                NSLog(@"点击了:%@",_storeArr[index]);
                if (index == _storeArr.count -1) {
                    

                }
                else{
                    
                    //                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    //                        // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
                    //                        manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
                    //                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
                    //                        NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kaddlabelUrl];
                    //                        NSDictionary * dic2 = @{
                    //                                                @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                    //                                                @"type":@"POSITION",
                    //                                                @"labelname":_storeArr[index],
                    //                                                @"phone":_phoneStr,
                    //
                    //                                                };
                    //
                    //                        NSLog(@"~~~~~~urlString:%@",urlString2);
                    //                        NSLog(@"~~~~~~dic:%@",dic2);
                    //                        [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    //
                    //                            NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    //                            NSLog(@"~~~~~~~response:%@",response);
                    //                            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                    //                            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    //
                    //
                    //                            if ([[json valueForKey:@"code"] intValue]==10000) {
                    //                                MessageModelViewController * messageVC = [[MessageModelViewController alloc] init];
                    //                                messageVC.typeStr = @"1";
                    //                                messageVC.labelStr = _storeArr[index];
                    //                                messageVC.phone = _phoneStr;
                    //                                messageVC.shopId = [tagsArray[index] valueForKey:@"shopId"];
                    //                                [[self getCurrentVC] presentViewController:messageVC animated:YES completion:^{
                    //
                    //                                }];
                    //                            }
                    //
                    //
                    //                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    //
                    //
                    //                        }];
                    
                    _tagStr = _storeArr[index];
                    _shopIdStr = [tagsArray[index] valueForKey:@"shopId"];
                    for (UIView * view in _othertagView.subviews) {
                        if ([view isKindOfClass:[UIButton class]]) {
                            UIButton * btn = (UIButton *)view;
                            [btn setSelected:NO];
                        }
                    }
                    for (UIView * view in _guizitagView.subviews) {
                        if ([view isKindOfClass:[UIButton class]]) {
                            UIButton * btn = (UIButton *)view;
                            [btn setSelected:NO];
                        }
                    }
                }
                
            };
            view.didRemoveTagAtIndex = ^(NSUInteger index){
                NSLog(@"删除了:%@",_storeArr[index]);
            };
            view;
        });
        self.storetagView.backgroundColor = [UIColor clearColor];
        self.storetagView.frame = CGRectMake(0, 0, kScreenWidth -  20, 400);
        [_storeView addSubview:self.storetagView];
        
        
        self.originalButtonCount = _storeArr.count;
        [_storeArr enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
            SKTag *tag = [SKTag tagWithText: text];
//            if (idx < tagsArray.count) {
//                tag.cbid = [tagsArray[idx] valueForKey:@"shopId"];
//            }
            tag.textColor = kGlobalBg;
            tag.slcTextColor = [UIColor whiteColor];
            [self dl_configTag:tag withIndex:idx];
            [self.storetagView addTag:tag];
        }];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"服务器异常";
        HUD.labelFont = [UIFont systemFontOfSize:16];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        [[self getCurrentViewController].view addSubview:HUD];
    }];
    
}

-(void)loadOtherData
{
    _ohterArr = [NSMutableArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    
    
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,klabellibgetlistUrl];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"title":@"smsLabel",
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([[json valueForKey:@"code"] intValue]==10000) {
            
            NSMutableArray *tagsArray = [NSMutableArray arrayWithArray:[json valueForKey:@"data"] ];
            
            for (int i = 0; i < tagsArray.count; i ++) {
                [_ohterArr addObject: tagsArray[i]];
            }     
        }
        else{
            
        }
        
        [_ohterArr addObject:@"   +   "];
        [self otherTagView];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"服务器异常";
        HUD.labelFont = [UIFont systemFontOfSize:16];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        [[self getCurrentViewController].view addSubview:HUD];
    }];
    
}


-(void)creatGuizi
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kexpresscabinetbuildUrl];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"cabName":_alertView.remarkField.text,
                            @"address":_alertView.msgField.text,
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([[json valueForKey:@"code"] intValue]==10000) {
//            [_tagArr addObject:_alertView.remarkField.text];
//            SKTag *tag = [SKTag tagWithText: _alertView.remarkField.text];
//            [self dl_configTag:tag withIndex:self.tagArr.count - 2];
//            [self.guizitagView insertTag:tag atIndex:_tagArr.count - 2];
            [self loadTagData];
        }
        else{
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"服务器异常";
        HUD.labelFont = [UIFont systemFontOfSize:16];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        [[self getCurrentViewController].view addSubview:HUD];
    }];
    
}



- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (IBAction)confirm:(UIButton *)sender {
    
    // 1.创建位置管理者
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    //设置期望精度
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    //设置代理
    locationManager.delegate = self;
    //开启定位
    [locationManager startUpdatingLocation];
    if (_tagStr.length > 0) {

    NSDictionary * dic = @{
                           @"place":_tagStr,
                           @"cabId":_cabIdStr.length >0?_cabIdStr:@"",
                           @"shopId":_shopIdStr.length > 0?_shopIdStr:@"",
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChoosePlaceTag" object:nil userInfo:dic];
       
    }
}

#pragma mark Corelocation delegate(定位成功)

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
     [manager stopUpdatingLocation];
    CLLocation * currentlocation  = [locations lastObject];
    NSDate *time = currentlocation.timestamp;
    //CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    NSLog(@"当前经纬度:%f---%f--%@",currentlocation.coordinate.latitude,currentlocation.coordinate.longitude,time);
    _Strlatitude = [NSString stringWithFormat:@"%f",currentlocation.coordinate.latitude];
    _Strlongitude = [NSString stringWithFormat:@"%f",currentlocation.coordinate.longitude];
    _nowTime = [NSString stringWithFormat:@"%lld",[DateTimeFormat longLongFromDate:time]];
   
    [self postLocation];
    
}
-(void)postLocation{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kpostLocationUrl];
    
    NSDictionary *dic1 = @{ @"lat":_Strlatitude,
                            @"lon":_Strlongitude,
                            @"time":_nowTime,};
    NSMutableArray *arr = [NSMutableArray arrayWithObject:dic1];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"records":jsonStr,
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([[json valueForKey:@"code"] intValue]==10000) {
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    
}
@end
