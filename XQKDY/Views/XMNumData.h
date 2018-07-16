//
//  XMNumData.h
//  拨号盘
//
//  Created by zyh on 16/6/13.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMNumData : NSObject
@property (nonatomic,strong) NSString *normal;
@property (nonatomic,strong) NSString *highlight;
@property (nonatomic,strong) NSString *num;
-(void)getData:(NSInteger)integer;
@end
