//
//  BaseNavigation.m
//  MaoWu
//
//  Created by 张正浩 on 16/3/1.
//  Copyright © 2016年 张正浩. All rights reserved.
//

#import "BaseNavigation.h"

@interface BaseNavigation ()

@end

@implementation BaseNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置显示的颜色
//    self.navigationBar.barTintColor = RGB(31, 154, 244);
    self.navigationBar.barTintColor = kGlobalBg;
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
    NSForegroundColorAttributeName:kGlobalBg}];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    
    // Do any additional setup after loading the view.
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
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

@end
