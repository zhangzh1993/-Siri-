//
//  Picker.m
//  MaoWu
//
//  Created by 张正浩 on 16/3/10.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "Picker.h"

@interface Picker ()
@property (nonatomic,retain)UIPickerView *pickerview;

@property (nonatomic,retain) UIToolbar *actionToolbar;
@end

@implementation Picker
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        
        self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, 216)];
        //    指定Delegate
        self.pickerview.delegate=self;
        self.pickerview.dataSource=self;
        //    显示选中框
        self.pickerview.showsSelectionIndicator=YES;
        [self addSubview:self.pickerview];

//        self.firstData=[[NSMutableArray alloc]initWithObjects:@"罗湖区",@"福田区",@"南山区",@"宝安区",@"龙岗区",@"盐田区",@"光明新区",@"龙华新区",@"坪山新区",@"大鹏新区",nil];
//        self.codeData=[[NSMutableArray alloc]initWithObjects:@"440303",@"440304",@"440305",@"440306",@"440307",@"440308",@"440309",@"440310",@"440311",@"440312",nil];

        self.actionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [self.actionToolbar sizeToFit];
        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickerCancelClicked:)];
        [cancelButton setTintColor:RGB(212, 61, 61)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(pickerDoneClicked:)];
        [doneBtn setTintColor:RGB(212, 61, 61)];
        [self.actionToolbar setItems:[NSArray arrayWithObjects:cancelButton,flexSpace,doneBtn, nil] animated:YES];
        [self addSubview:self.pickerview];
        [self addSubview:self.actionToolbar];
        

    }
    return self;
}

-(void)pickerCancelClicked:(UIBarButtonItem*)barButton{
    [UIView animateWithDuration:0.5 animations:^{
        //480 是屏幕尺寸
        self.frame=CGRectMake(0, kScreenHeight, kScreenWidth, 260);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)pickerDoneClicked:(UIBarButtonItem*)barButton{
    if ([self.firstStr isEqual:[NSNull null]]) {
        
    }
    else
    {
    NSDictionary * dic = @{
                           @"place":self.firstStr,
                           @"code":self.firstCode,
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"place" object:nil userInfo:dic];
    }
    NSLog(@"获取信息%@",self.firstStr);
    [UIView animateWithDuration:0.5 animations:^{
        //480 是屏幕尺寸
        self.frame=CGRectMake(0, kScreenHeight, kScreenWidth, 260);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    self.firstStr= self.firstData[0];
    self.firstCode = self.codeData [0];

    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.firstData count];
    
    
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.firstData objectAtIndex:row];
    
}
-(void)pickerView:(UIPickerView *)pickerViewt didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.firstStr = [self.firstData objectAtIndex:row];
    self.firstCode = [self.codeData objectAtIndex:row];
}
//设置滚轮的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 200;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
