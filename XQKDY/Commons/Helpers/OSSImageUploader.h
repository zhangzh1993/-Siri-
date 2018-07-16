//
//  OSSImageUploader.h
//  OSSImsgeUpload
//
//  Created by cysu on 5/31/16.
//  Copyright © 2016 cysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UploadImageState) {
    UploadImageFailed   = 0,
    UploadImageSuccess  = 1
};

@interface OSSImageUploader : NSObject

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images names:(NSArray *)name complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;
+ (void)uploadImages:(NSArray<UIImage *> *)images names:(NSArray *)name isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;
@end
