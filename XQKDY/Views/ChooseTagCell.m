//
//  ChooseTagCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/5/9.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "ChooseTagCell.h"

@implementation ChooseTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tagSelectArr = [NSMutableArray new];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setData:(NSDictionary *)data
{
    _data = data;
    //    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.05];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self loadData];
         _selectIndexArr = [NSMutableArray new];
    });
    
}
-(void)loadData
{
    if (_tagNameLabel.text.length == 0) {
        
        self.tagArr = [NSMutableArray arrayWithArray:[_data valueForKey:@"record"]];
        [self.tagArr addObject:@{
                                 @"labelname":@"",
                                 }];
        self.tagView.dataSource = self;
        self.tagView.selectArr = _tagSelectArr;
        self.tagView.delegate = self;
        self.tagView.bgColor = RGB(240, 240, 240);
        self.tagView.textColor = RGB(150, 150, 150);
        self.tagView.selectedTextColor = RGB(115, 179, 255);
        self.tagView.selectBgColor= RGB(245, 250, 255);
        self.tagView.maxSelectNum = 0;
        self.tagView.isBule = @"1";
        self.tagView.itemWidth = 0;
        self.tagView.itemHeight = 0;
        [self.tagView reloadData];
        self.tagViewHeight.constant = CGRectGetHeight(self.tagView.frame);
        _tagNameLabel.text = [_data valueForKey:@"title"];
        
    }
    
}
#pragma mark - MGSelectionTagViewDataSource

- (NSInteger)numberOfTagsInSelectionTagView:(MGSelectionTagView *)tagView {
    
    return self.tagArr.count;
    
}

- (NSString *)tagView:(MGSelectionTagView *)tagView titleForIndex:(NSInteger)index {
    
    return [[self.tagArr valueForKey:@"labelname"] objectAtIndex:index];
    
}

/**
 *  标识index位置的tag是否选中
 *
 */
- (BOOL)tagView:(MGSelectionTagView *)tagView isTagSelectedForIndex:(NSInteger)index {
    
    
    if ([_selectIndexArr containsObject: [[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]]) {
        return  YES;
    }

    return NO;
}

/**
 *  标识index位置的tag是否“其他”（设置了“其他”tag会在选择时产生互斥）
 *
 */
- (BOOL)tagView:(MGSelectionTagView *)tagView isOtherTagForIndex:(NSInteger)index {
    
    return NO;
}



#pragma mark - MGSelectionTagViewDelegate

-(void)removeTagView:(MGSelectionTagView *)tagView tagAtIndex:(NSInteger)index
{
    MBProgressHUD *  loadingHUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
    loadingHUD.mode = MBProgressHUDModeIndeterminate;
    loadingHUD.delegate = self;
    loadingHUD.labelFont = [UIFont systemFontOfSize:16];
    [loadingHUD show:YES];
    [[self getCurrentViewController].view addSubview:loadingHUD];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,klabelgrouptodelUrl];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"title":_tagNameLabel.text,
                            @"labelname":[[self.tagArr objectAtIndex:index] valueForKey:@"labelname"],
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [loadingHUD hide:YES];
        
        if ([[json valueForKey:@"code"] intValue]==10000) {
            NSMutableArray * tmpArr = [NSMutableArray arrayWithArray:self.tagArr];
            [tmpArr removeObjectAtIndex:index];
            self.tagArr = [NSMutableArray arrayWithArray:tmpArr];
            [self.tagView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
        }
        
        HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = [json valueForKey:@"msg"];
        HUD.labelFont = [UIFont systemFontOfSize:16];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        [[self getCurrentViewController].view addSubview:HUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [loadingHUD hide:YES];
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

- (void)tagView:(MGSelectionTagView *)tagView tagTouchedAtIndex:(NSInteger)index {
    
    NSLog(@"select tag:%@",[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]);
    
    if ([self.selectIndexArr containsObject:[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]]) {
        [self.selectIndexArr removeObject:[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]];
    }
    else
    {
        [self.selectIndexArr addObject:[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]];
   
    }
    if ([[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index] isEqualToString:@""]) {
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
        [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [_publishView addSubview:confirmBtn];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            _publishView.frame = CGRectMake(20, kScreenHeight/2-100, kScreenWidth-40, 150);
        }];
    }
    else{
        
        [_tagSelectArr addObject:[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]];
        NSDictionary * dic = @{
                               @"title":_tagNameLabel.text,
                               @"labelnames":_tagSelectArr,
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChooseTag" object:nil userInfo:dic];
    }
    [self.tagView reloadData];
    
}
-(void)tap:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _publishView.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
        [_bgView removeFromSuperview];
    }];
}
-(void)confirm:(UIButton *)sender
{
    if (classifyTextField.text.length > 0) {
        
        MBProgressHUD *  loadingHUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
        loadingHUD.mode = MBProgressHUDModeIndeterminate;
        loadingHUD.delegate = self;
        loadingHUD.labelFont = [UIFont systemFontOfSize:16];
        [loadingHUD show:YES];
        [[self getCurrentViewController].view addSubview:loadingHUD];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
        NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,ktoaddUrl];
        NSDictionary * dic2 = @{
                                @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                                @"title":_tagNameLabel.text,
                                @"labelname":classifyTextField.text,
                                };
        
        NSLog(@"~~~~~~urlString:%@",urlString2);
        NSLog(@"~~~~~~dic:%@",dic2);
        [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"~~~~~~~response:%@",response);
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            [loadingHUD hide:YES];
            if ([[json valueForKey:@"code"] intValue]==10000) {
                [UIView animateWithDuration:0.3 animations:^{
                    _publishView.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
                    [_bgView removeFromSuperview];
                }];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
            }
            
            HUD = [[MBProgressHUD alloc] initWithView:[self getCurrentViewController].view];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText = [json valueForKey:@"msg"];
            HUD.labelFont = [UIFont systemFontOfSize:16];
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            [[self getCurrentViewController].view addSubview:HUD];
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [loadingHUD hide:YES];
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
    else{
        kShowAlertView(@"提示", @"请输入完整参数", @"确定");
    }
    
    
    
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
@end
