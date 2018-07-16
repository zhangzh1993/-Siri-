//
//  TagCell.m
//  XQKDY
//
//  Created by 张正浩 on 2017/5/5.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    


    // Initialization code
}
-(void)setData:(NSDictionary *)data
{
    _data = data;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];

//    [self loadData];
}
-(void)loadData
{
    self.tagArr = [NSMutableArray arrayWithArray:[_data valueForKey:@"record"]];
    [self.tagArr addObject:@{
                             @"labelname":@"",
                             }];
    self.tagView.dataSource = self;
    self.tagView.delegate = self;
    self.tagView.bgColor = RGB(245, 250, 255);
    self.tagView.textColor = RGB(115, 179, 255);
    self.tagView.selectedTextColor = RGB(115, 179, 255);
    self.tagView.selectBgColor= RGB(245, 250, 255);
    self.tagView.maxSelectNum = 1;
    self.tagView.isBule = @"1";
    self.tagView.itemWidth = 0;
    self.tagView.itemHeight = 0;
    [self.tagView reloadData];
    self.tagViewHeight.constant = CGRectGetHeight(self.tagView.frame);
    
    _tagNameLabel.text = [NSString stringWithFormat:@"%@",[_data valueForKey:@"title"]];

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

- (void)tagView:(MGSelectionTagView *)tagView tagTouchedAtIndex:(NSInteger)index {
    
    NSLog(@"select tag:%@",[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index]);
    
    if ([[[self.tagArr valueForKey:@"labelname"] objectAtIndex:index] isEqualToString:@""]) {
 
    }
    else{
//        AddTagViewController * addtagVC = [[AddTagViewController alloc] init];
//        [[self getCurrentViewController].navigationController pushViewController:addtagVC animated:YES];
    }

}
-(void)removeTagView:(MGSelectionTagView *)tagView tagAtIndex:(NSInteger)index
{
    
    NSLog(@"remove tag:%@",[self.tagArr objectAtIndex:index]);

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
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kdelrecordUrl];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"phone":[self getCurrentViewController].title,
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)prepareDataSource {
    
    NSArray * arr = @[@"书画",@"芭蕾舞",@"烹饪",@"时装模特",@"北京一日游",@"音乐",@"太极拳",@"广场舞",@"添加"];
    self.tagArr = [NSMutableArray arrayWithArray:_data];
    
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
