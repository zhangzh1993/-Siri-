//
//  XMDropDownChooseView.m
//  Created by Felix on 14-3-17.
//  Copyright (c) 2014年 xxyyzz. All rights reserved.
//

#import "XMDropDownChooseView.h"
#import "UIImageView+WebCache.h"
@interface XMDropDownChooseView ()


/**
 用来接收筛选器列表数据
 */
@property(nonatomic,strong)NSArray * dataArr;
/**
 当前打开的section，默认为-1，表示没有点开哪个section
 */
@property(nonatomic,assign)NSInteger currentExtendSection;

/**
 按钮显示文字数组，用来判定筛选器列表选中文字
 */
@property(nonatomic,strong)NSMutableArray * btnTitles;

@end
@implementation XMDropDownChooseView

static NSString * const ListTableViewID = @"ListTableView";

- (id)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.chooseDelegate = delegate;
        _dataArr = dataArr;
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    _btnTitles = [NSMutableArray array];

    _currentExtendSection = -1;//当前打开的section，默认为-1，表示没有点开哪个section
    //初始化默认显示View
    CGFloat sectionWith = (1.0*self.bounds.size.width/_dataArr.count);
    for (int i=0; i<_dataArr.count; i++) {
        UIButton *sectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(sectionWith*i, 1, sectionWith, self.bounds.size.height - 2)];
        sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
        [sectionBtn addTarget:self action:@selector(sectionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *sectionBtnTitle = _dataArr[i][0];
        [_btnTitles addObject:sectionBtnTitle];
        [sectionBtn setTitle:sectionBtnTitle forState:UIControlStateNormal];
        [sectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sectionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:sectionBtn];
        
        UIImageView *sectionBtnIv = [[UIImageView alloc]initWithFrame:CGRectMake(sectionWith*i + (sectionWith - 16), (self.bounds.size.height - 12)/2, 12, 12)];
        [sectionBtnIv setImage:[[UIImage imageNamed:@"down_dark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        sectionBtnIv.tintColor = [UIColor whiteColor];
        [sectionBtnIv setContentMode:UIViewContentModeScaleAspectFit];
        sectionBtnIv.tag = SECTION_IV_TAG_BEGIN + i;
        [sectionBtn setBackgroundColor: [UIColor clearColor]];
        [self addSubview:sectionBtnIv];
        
        if(i < _dataArr.count && i > 0 ){
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(sectionWith*i , self.bounds.size.height/4, 1, self.bounds.size.height/2)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
        }
    }
    self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, W_PATH, H_PATH - self.bounds.origin.y - self.bounds.size.height)];
    self.backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTappedAction:)];
    [self.backGroundView addGestureRecognizer:bgTap];
    
    self.ListTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, 64, W_PATH, 0) style:UITableViewStylePlain];
    self.ListTableView.delegate = self;
    self.ListTableView.dataSource = self;
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap{
    [self hideExtendedChooseView];
}

/**
 重置筛选器状态
 */
-(void)recoverAllSectionBtnStatus{
    for (UIView *tempView in [self subviews]) {
        if(tempView.tag >= SECTION_BTN_TAG_BEGIN && [tempView isKindOfClass:[UIButton class]]){

        }
        
        if(tempView.tag >= SECTION_IV_TAG_BEGIN && [tempView isKindOfClass:[UIImageView class]]){
            [((UIImageView *)tempView) setImage:[[UIImage imageNamed:@"down_dark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];


        }
    }
}

-(void)sectionBtnAction:(UIButton *)btn{
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    
    if(_currentExtendSection == section){

        [self hideExtendedChooseView];
        
    }else{
        if (!_titleColor) {
            _titleColor = [UIColor blueColor];
        }
        _currentExtendSection = section;
        [self recoverAllSectionBtnStatus];
        
//        UIImageView *currentIv = (UIImageView *)[self viewWithTag:(3000 + section)];
//        [currentIv setImage:[[UIImage imageNamed:@"up_light.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
//        currentIv.tintColor = _titleColor;

        [self showExtendedChooseView];
    }
}

/**
 移除筛选器列表
 */
-(void)hideExtendedChooseView{
    
    [self recoverAllSectionBtnStatus];
    
    if(_currentExtendSection != -1){
        _currentExtendSection = -1;
        [UIView animateWithDuration:0.2 animations:^(void){
            
            
            CGRect frame = self.ListTableView.frame;
            frame.size.height = 0;
            self.ListTableView.frame = frame;
            self.backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            
        } completion:^(BOOL finished){
            
            [self.ListTableView removeFromSuperview];
            [self.backGroundView removeFromSuperview];
            
        }];
    }
}

/**
 展示筛选器列表
 */
-(void)showExtendedChooseView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backGroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:_ListTableView];
    
     CGFloat tableViewHeight = ([_dataArr[_currentExtendSection] count] > 5) ? (5 * 40) : ([_dataArr[_currentExtendSection] count] * 40);
    [UIView animateWithDuration:0.2 animations:^(void){
        CGRect frame = self.ListTableView.frame;
        frame.size.height = tableViewHeight;
        self.ListTableView.frame = frame;
        self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.2];
    }];
    [self.ListTableView reloadData];
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr[_currentExtendSection] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListTableViewID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListTableViewID];
    }
    cell.textLabel.text = _dataArr[_currentExtendSection][indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.textColor = [UIColor grayColor];
    if ([cell.textLabel.text isEqualToString:[_btnTitles objectAtIndex:_currentExtendSection]]) {
        cell.tintColor = _titleColor;
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [cell.textLabel setTextColor:_titleColor];
    }
    if (_imageArr.count > 0) {
        CGSize size = CGSizeMake(20, 20);
        UIImage * image = [self imageFromURLString:_imageArr[indexPath.row]];
        cell.imageView.size = size;
        cell.imageView.image = image;
        //调整image的大小
        UIGraphicsBeginImageContextWithOptions(size, NO,0.0);
        CGRect imageRect=CGRectMake(0.0, 0.0, size.width, size.height);
        [image drawInRect:imageRect];
        cell.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return cell;
}
- (UIImage *) imageFromURLString: (NSString *) urlstring
{
    // This call is synchronous and blocking
    return [UIImage imageWithData:[NSData
                                   dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *choosedCellTitle = _dataArr[_currentExtendSection][indexPath.row];
    [_btnTitles setObject:choosedCellTitle atIndexedSubscript:_currentExtendSection];
    UIButton *currentSectionBtn = (UIButton *)[self viewWithTag:1000 + _currentExtendSection];
    [currentSectionBtn setTitle:choosedCellTitle forState:UIControlStateNormal];
    if ([self.chooseDelegate respondsToSelector:@selector(choosedAtSection:index:)]) {
         [self.chooseDelegate choosedAtSection:_currentExtendSection index:indexPath.row];
    }
    [self hideExtendedChooseView];
}


@end
