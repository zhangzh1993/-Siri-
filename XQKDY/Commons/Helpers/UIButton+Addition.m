//
//  UIButton+Addition.m
//  TWApp
//
//  Created by line0 on 13-7-11.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+ (UIButton *)buttonWithNImage:(UIImage *)nimage pImage:(UIImage *)pImage delegate:(id)del selector:(SEL)sel
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:nimage forState:UIControlStateNormal];
    [btn setImage:pImage forState:UIControlStateHighlighted];
    [btn addTarget:del action:sel forControlEvents:UIControlEventTouchUpInside];
//    btn.layer.borderColor =ThemeColor.CGColor;
//    btn.layer.borderWidth = 0.3;
    [btn sizeToFit];
    return btn;
}

+ (UIButton *)buttonWithNormalImage:(UIImage *)image andTitle:(NSString*)title width:(CGFloat)aWidth height:(CGFloat)aHeight target:(id)aTarget selector:(SEL)aSelector{
    //    UIImage *img = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0 )];
    UIImage *img = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
    
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(0, 0, aWidth, aHeight);
    
    [btn addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
 
+ (UIButton *)buttonWithStr:(NSString *)strTitle
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customButton setTitle:strTitle forState:UIControlStateNormal];
    [customButton setTitle:strTitle forState:UIControlStateHighlighted];
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [customButton.titleLabel setFont:[UIFont boldSystemFontOfSize:FontSizeOfButton]];
    [customButton setBackgroundColor:ColorButtonBackground];

    customButton.layer.cornerRadius = 5;
    [customButton sizeToFit];
    [customButton setFrame:CGRectMake(customButton.frame.origin.x, CGRectGetMinY(customButton.frame), CGRectGetWidth(customButton.frame) + FontSizeOfButton* 0.618, FontSizeOfButton * 1.618)];

    return customButton;
}

+ (UIButton *)buttonReverseColorWithStr:(NSString *)strTitle
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customButton setTitle:strTitle forState:UIControlStateNormal];
    [customButton setTitle:strTitle forState:UIControlStateHighlighted];
    [customButton setTitleColor:ColorButtonBackground forState:UIControlStateNormal];

    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [customButton.titleLabel setFont:[UIFont boldSystemFontOfSize:FontSizeOfButton]];
    [customButton setBackgroundColor:[UIColor whiteColor]];

    customButton.layer.cornerRadius = 5;
    customButton.layer.borderColor = ColorButtonBackground.CGColor;
    customButton.layer.borderWidth = 1;
    
    [customButton sizeToFit];
    [customButton setFrame:CGRectMake(customButton.frame.origin.x, CGRectGetMinY(customButton.frame), CGRectGetWidth(customButton.frame) + FontSizeOfButton* 0.618, FontSizeOfButton * 1.618)];
    return customButton;
}

+ (UIButton *)buttonLoginWithStr:(NSString *)strTitle
{
    UIColor* darkcolor = [UIColor colorWithRed:131.0/255.0 green:6.0/255.0 blue:30.0/255.0 alpha:1];
    UIColor* lightcolor = [UIColor colorWithRed:219.0/255.0 green:156.0/255.0 blue:168.0/255.0 alpha:1];
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customButton setTitle:strTitle forState:UIControlStateNormal];
    [customButton setTitle:strTitle forState:UIControlStateHighlighted];
    [customButton setTitleColor:darkcolor forState:UIControlStateNormal];
    
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [customButton.titleLabel setFont:[UIFont boldSystemFontOfSize:FontSizeOfButton]];
    [customButton setBackgroundColor:lightcolor];
    
    customButton.layer.cornerRadius = 10;
    customButton.layer.borderColor = darkcolor.CGColor;
    customButton.layer.borderWidth = 2;
    
    [customButton sizeToFit];
    [customButton setFrame:CGRectMake(customButton.frame.origin.x, CGRectGetMinY(customButton.frame), CGRectGetWidth(customButton.frame) + FontSizeOfButton* 0.618, FontSizeOfButton * 1.618)];
    return customButton;
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)t target:(id)tgt action:(SEL)a
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:15.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = [t sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 24.0;

    [button setFrame:buttonFrame];
 
    [button setTitle:t forState:UIControlStateNormal];
    
    [button addTarget:tgt action:a forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return buttonItem;
}
 
@end
