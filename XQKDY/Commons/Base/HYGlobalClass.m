
//
//  HYGlobalClass.m
//  CompressImage
//
//  Created by hy_les on 15/12/25.
//  Copyright © 2015年 HL. All rights reserved.
//

#import "HYGlobalClass.h"

static HYGlobalClass *instance = nil;

@implementation HYGlobalClass

#pragma mark -
#pragma mark -  得到单例对象
+(HYGlobalClass *) getInstance;//单例类对象获取方法
{
    if (instance==nil)
    {
        instance = [[HYGlobalClass alloc]init];
    }
    return instance;
}


#pragma mark -
#pragma mark - 将图片压缩到限定的大小(不一定符合要求，需要自己进行判断，返回图片已经压缩到极限)
-(UIImage *)compressionImageToLimitSizeWithImage:(UIImage *)image
{
    //1、原来大小
    NSData *pngData = UIImagePNGRepresentation(image);// 测试png格式图片大小
    float lastSize = pngData.length/1024.0;//原始图片的大小 KB
    
    lastImageSize = lastSize;
    
//    NSLog(@"处理之前图片的大小：%fKB",lastSize);
    
    UIImage *temImage = [UIImage imageWithData:pngData];//临时图片
    
    //判断原来的大小是否符合规定的尺寸
    if ([self judgeImageWhetherMeetTheRequiredSize:image]) {
        
//        NSLog(@"原来图片小于规定尺寸");
        return temImage;
    }
    
    //2、缩小图片
    
    //a、判断是否符合缩小的规定
    if (image.size.width>kScreenWidth || image.size.height>kScreenHeight)
    {
        //两者有一个大于屏幕的尺寸，便可进行缩小处理
        
        //b、判断以哪个轴为参考轴
        BOOL referAxisIsY = NO;//标记参考轴是否是Y轴
        
//        NSLog(@"图片尺寸的比值：%f 屏幕尺寸的比值:%f",image.size.width/image.size.height,kScreenWidth/kScreenHeight);
        
        if (image.size.width/image.size.height > kScreenWidth/kScreenHeight)
        {
            
            referAxisIsY = NO;
        }
        else
        {
            referAxisIsY = YES;
        }
        
        //缩小处理
        temImage = [self imageCompressForImage:image isAxisY:referAxisIsY];
        
        
    }
    else
    {
        //尺寸太小的情况下直接执行压图片处理
        temImage = [self imagesPressToLimitSize:temImage];
    }
    
    
    if (![self judgeImageWhetherMeetTheRequiredSize:temImage]) {
        NSData *pngData = UIImagePNGRepresentation(temImage);// 测试png格式图片大小
        float tempSize = pngData.length/1024.0;//原始图片的大小 KB
        //如果传入图片大小和处理后图片大小相等不需要递归处理
        if (fabsf(lastImageSize - tempSize)<0.000001 || fabsf(tempSize - lastImageSize)<0.000001)
        {
            
        }
        else
        {
//            NSLog(@"递归的调用方法");
            temImage = [self compressionImageToLimitSizeWithImage:temImage];
        }
    }
    return temImage;
}


#pragma mark -
#pragma mark - 将图片缩小
-(UIImage *)imageCompressForImage:(UIImage *)image isAxisY:(BOOL)isY
{
    NSData *imageData = UIImagePNGRepresentation(image);//
    
    UIImage *temImage = [UIImage imageWithData:imageData];//得到临时image
    
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (isY)
    {
        //Y轴为参考轴
        
        double cardinalY = 0.0;
        for (int i = 0; i<3; i++)
        {
            if (i==0)
            {
                float baseNum = height>kScreenHeight ? kScreenHeight/height:height/kScreenHeight;
                cardinalY = sqrt(baseNum);
            }
            else
            {
                cardinalY = sqrt(cardinalY);
            }
        }
        
//        NSLog(@"Y轴时候的基数是：%f",cardinalY);
        
        while (![self judgeImageWhetherMeetTheRequiredSize:temImage])
        {
            //不符合尺寸大小要求
            
            if (height>kScreenHeight)
            {
                height = height*cardinalY;
                width  = width*cardinalY;
                
                //缩小处理
                temImage = [self imageCompressForImage:image targetWidth:width];
                
//                NSLog(@"这个时候的 高度：%f 宽度：%f",height,width);
            }
            else
            {
                break;
            }
        }
        
    }
    else
    {
        //X轴为参考轴
        
        double cardinalX = 0.0;
        for (int i = 0; i<3; i++)
        {
            if (i==0)
            {
                float baseNum = width>kScreenWidth ? kScreenWidth/width:width/kScreenWidth;
                cardinalX = sqrt(baseNum);
            }
            else
            {
                cardinalX = sqrt(cardinalX);
            }
        }
        
//        NSLog(@"X轴为参考时候的基数是：%f",cardinalX);
        
        while (![self judgeImageWhetherMeetTheRequiredSize:temImage])
        {
            //不符合尺寸大小要求
            
            if (width>kScreenWidth)
            {
                width = width*cardinalX;
                
//                NSLog(@"这个时候的宽度：%f",width);
                
                //缩小处理
                temImage = [self imageCompressForImage:image targetWidth:width];
                
            }
            else
            {
                break;
            }
        }
        
    }
    
    return temImage;
}


#pragma mark -  图片处理 开始
#pragma mark - (压)将图片压到小于限定的大小 ,文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降
-(UIImage *)imagesPressToLimitSize:(UIImage *)orgImage
{
    
    double compression = 1.0f;
    
    NSData *orgData = UIImageJPEGRepresentation(orgImage, compression);
    
    UIImage *newImage = [UIImage imageWithData:orgData];//转成新的图片
    
    NSData *pngData = UIImagePNGRepresentation(orgImage);// 测试png格式图片大小
    
    float imageSize = pngData.length/1024.0;//原始图片的大小
    
    float flag;
    
//    NSLog(@"压图片处理： JPG原始图片大小：%f KB  PNG原始图片大小%f KB",(unsigned long)orgData.length/1024.0,imageSize);
    
    
    while(![self judgeImageWhetherMeetTheRequiredSize:orgImage])
    {
        flag = imageSize;
        compression  = compression*pow(0.1, 2);
        orgData = UIImageJPEGRepresentation(orgImage, compression);
        
        newImage = [UIImage imageWithData:orgData];//转成新的图片
        pngData = UIImagePNGRepresentation(newImage);//测试png格式图片大小
        
        imageSize = pngData.length/1024.0;
        
//        NSLog(@"压图片处理：compression：%f",compression);
//        
//        NSLog(@"进行压图片处理： JPG原始图片大小：%f KB  PNG原始图片大小%f KB",(unsigned long)orgData.length/1024.0,imageSize);
        
        if (fabsf(flag - imageSize)<pow(0.1, 6)|| fabsf(imageSize - flag)<pow(0.1, 6))
        {
            break;
        }
        
    }
    
    UIImage * totolImage = [UIImage imageWithData:orgData];
    
//    float newImageSize = orgData.length/1024.0;//原始图片的大小
//    
//    UIImage *pngImage = [UIImage imageWithData:orgData];//转成新的图片
//    
//    NSData *pngLastData = UIImagePNGRepresentation(pngImage);// 测试png格式图片大小
//    
//    NSLog(@"压图片处理最终得到的：JPG新图片大小：%fKB  png:%fKB",newImageSize,pngLastData.length/1024.0);
    return totolImage;
}


#pragma mark -
#pragma mark - (缩) 缩小图片像素点到指定宽度，文件的尺寸变小，也就是像素数减少。长宽尺寸变小，体积同样会减小。（长度比例不变）
-(UIImage *)imageCompressForImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    /*
    NSData *pngData = UIImagePNGRepresentation(newImage);// 测试png格式图片大小
    float lastSize = pngData.length/1024.0;//原始图片的大小
    
    NSLog(@"缩 处理之后的图片的大小：%fKB",lastSize);*/
    return newImage;
}


#pragma mark -
#pragma mark - (缩小)图片裁剪
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    
//    NSData *pngData = UIImagePNGRepresentation(newImage);// 测试png格式图片大小
//    float lastSize = pngData.length/1024.0;//原始图片的大小
//    NSLog(@"裁剪 处理之后的图片的大小：%f",lastSize/1024.0);
    
    // Return the new image.
    return newImage;
}


#pragma mark -
#pragma mark - 判断图片是否符合要求的尺寸 （YES:符合 NO：不符合）
-(BOOL)judgeImageWhetherMeetTheRequiredSize:(UIImage *)orgImage
{
    //转成data数据
    NSData * data = UIImagePNGRepresentation(orgImage);
    
    //NSLog(@"判断是否符合要求，现在图片的大小：%luBit : %fKB",(unsigned long)data.length,data.length/1024.0);
    
    float imageSize = data.length/1024.0;//原始图片的大小
    
    if (imageSize > KImageMaxKB)
    {
        return NO;
    }
    
    return YES;
}


#pragma mark -
#pragma mark - 将图片保存的沙盒路径下
-(void)saveImageToSandBox:(UIImage *)image withImageName:(NSString *)name;
{
    
    //将图片保存到沙盒
    //保存文件到沙盒
    //获取沙盒中Documents目录路径
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths  objectAtIndex:0];
    NSLog(@"沙盒路径:%@",documentsDirectory);
    
    //拼接文件绝对路径
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"图片"];
    
    NSString *filePath = [myDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"pic—%@.png",name]];
    NSLog(@"图片地址:%@",filePath);
    
    //保存
    [fileManager createDirectoryAtPath:myDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    
    
}

#pragma mark - 图片处理 结束


#pragma mark
#pragma mark - 得到字符串长度 中英文混合情况下
- (int)lengthToInt:(NSString*)string;
{
    //去掉空格
    NSString *st = [string  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    int strlength = 0;
    char* p = (char*)[st cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[st lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}

@end
