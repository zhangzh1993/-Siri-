//
//  PersonCell.m
//  BM
//
//  Created by yuhuajun on 15/7/13.
//  Copyright (c) 2015年 yuhuajun. All rights reserved.
//

#import "PersonCell.h"
#import "CDFInitialsAvatar.h"
@implementation PersonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellviewbackground"]];
        
        _tximg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 50,50)];
        [self.contentView addSubview:_tximg];
        
        CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:_tximg.bounds fullName:@"测试"];
        topAvatar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tx_five"]];
        topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:20];
        CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
        UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
        mask.contents = (id)[maskImage CGImage];
        mask.frame = _tximg.bounds;
        _tximg.layer.mask = mask;
        //_tximg.layer.cornerRadius = YES;
        _tximg.image = topAvatar.imageRepresentation;
        _topAvatar=topAvatar;
        
        
        _txtName=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 160, 25)];
        _txtName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16];
        
        [self.contentView addSubview:_txtName];
        
        _phoneNum=[[UILabel alloc]initWithFrame:CGRectMake(80, 35, 160, 25)];
        _phoneNum.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13];
        [self.contentView addSubview:_phoneNum];

        
        _addresslable = [[UILabel alloc] initWithFrame:CGRectMake(_phoneNum.left, _phoneNum.bottom , 200, 20)];
        _addresslable.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13];
         [self.contentView addSubview:_addresslable];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_tximg.right - 20, _tximg.bottom - 20, 20, 20)];
        _iconImageView.layer.cornerRadius = 10.0f;
        [self.contentView addSubview:_iconImageView];

 
    }
    return self;
}
-(void)setTxcolorAndTitle:(NSString*)title fid:(NSString*)fid
{
    NSArray *tximgLis=@[@"tx_one",@"tx_two",@"tx_three",@"tx_four",@"tx_five"];
    NSString *strImg;
    if(fid.length!=0)//利用号码不同来随机颜色
    {
       NSString *strCarc= fid.length<7? [fid substringToIndex:fid.length]:[fid substringToIndex:7];
       int allnum=[strCarc intValue];
       strImg=tximgLis[allnum%5];
    }else
    {
      strImg=tximgLis[0];
    }
    if(title.length!=0)
    {
       title= title.length<1? [title substringToIndex:title.length]:[title substringToIndex:1];
    }else
    {
       title=@"测试";
    }
    
    CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:_tximg.bounds fullName:title];
    
    topAvatar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:strImg]];
    
    topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
    CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
    UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
    mask.contents = (id)[maskImage CGImage];
    mask.frame = _tximg.bounds;
    _tximg.layer.mask = mask;
    _tximg.layer.cornerRadius = YES;
    _tximg.image = topAvatar.imageRepresentation;
    _topAvatar=topAvatar;
    
}
-(void)setData:(PersonModel*)personDel;
{
    _txtName.text=personDel.nickname;
    _phoneNum.text=personDel.phone;
    _addresslable.text=personDel.address;
    if ([personDel.hasPhone integerValue] == 1) {
        _iconImageView.image = [UIImage imageNamed:@"icon_phone label_"];
    }
    else
    {
        _iconImageView.image = [UIImage imageNamed:@""];
    }
    [self setTxcolorAndTitle:personDel.nickname fid:personDel.phone];
 

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
