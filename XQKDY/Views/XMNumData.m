//
//  XMNumData.m
//  拨号盘
//
//  Created by zyh on 16/6/13.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import "XMNumData.h"

@implementation XMNumData
{
    NSArray *_normalArr; //存放普通号码按钮图片
    NSArray *_highlightArr;//存放高亮号码按钮图片
    NSArray *_numArr; //存号码
  
}
-(instancetype)init{
   
   return [super init];
}
#pragma mark 从plist获取图片
-(void)getData:(NSInteger)integer{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NumberList" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
     _normalArr = [dic objectForKey:@"normalNum"];
    _highlightArr  = [dic objectForKey:@"highlight"];
    _numArr = [dic objectForKey:@"Num"];
    self.normal = _normalArr[integer];
    self.highlight = _highlightArr[integer];
    self.num = _numArr[integer];
}
@end
