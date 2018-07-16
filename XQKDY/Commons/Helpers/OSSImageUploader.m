//
//  OSSImageUploader.m
//  OSSImsgeUpload
//
//  Created by cysu on 5/31/16.
//  Copyright © 2016 cysu. All rights reserved.
//

#import "OSSImageUploader.h"
#import <AliyunOSSiOS/OSSService.h>

@implementation OSSImageUploader
NSString * AccessKey = @"your-key";
NSString * SecretKey = @"your-secret";
NSString * BucketName = @"onetouch";
NSString * AliYunHost = @"http://oss-cn-shenzhen.aliyuncs.com";

static NSString *kTempFolder = @"temp";


+ (void)asyncUploadImages:(NSArray<UIImage *> *)images names:(NSArray *)name complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images names:name isAsync:YES complete:complete];
}


+ (void)uploadImages:(NSArray<UIImage *> *)images names:(NSArray *)name isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSString * urlString  = [NSString stringWithFormat:@"%@%@",kbaseUrl,@"/oss/getimgtoken"];
    NSDictionary * dic = @{
                           @"uid":[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],
                           @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                           };
    NSLog(@"~~~~~~urlString:%@",urlString);
    NSLog(@"~~~~~~postDic:%@",dic);
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([[json valueForKey:@"code"] intValue]==10000) {

            AccessKey = [[json valueForKey:@"data"] objectForKey:@"AccessKeyId"];
            SecretKey = [[json valueForKey:@"data"] objectForKey:@"AccessKeySecret"];
            
            id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
                OSSFederationToken * getFederationToken = [[OSSFederationToken alloc] init];
                getFederationToken.tAccessKey = AccessKey;
                getFederationToken.tSecretKey = SecretKey;
                getFederationToken.tToken = [[json valueForKey:@"data"] objectForKey:@"SecurityToken"];
                getFederationToken.expirationTimeInGMTFormat = [[json valueForKey:@"data"] objectForKey:@"Expiration"];
                return getFederationToken;
            }];

            
            OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliYunHost credentialProvider:credential];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            queue.maxConcurrentOperationCount = images.count;
            
            NSMutableArray *callBackNames = [NSMutableArray array];

            for (int i = 0; i < images.count; i ++) {

                    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                        //任务执行
                        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                        put.bucketName = BucketName;
                        put.objectKey = name[i];
                        [callBackNames addObject:name[i]];
                        NSData *data = UIImageJPEGRepresentation(images[i], 0.3);
                        put.uploadingData = data;
                        
                        OSSTask * putTask = [client putObject:put];
                        [putTask waitUntilFinished]; // 阻塞直到上传完成
                        if (!putTask.error) {
                            NSLog(@"upload object success!");
                        } else {
                            NSLog(@"upload object failed, error: %@" , putTask.error);
                        }
                        if (isAsync) {
                            if (i == images.count -1) {
                                NSLog(@"upload object finished!");
                                if (complete) {
                                    complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
                                }
                            }
                        }
                    }];
                    if (queue.operations.count != 0) {
                        [operation addDependency:queue.operations.lastObject];
                    }
                    [queue addOperation:operation];

            }
            if (!isAsync) {
                [queue waitUntilAllOperationsAreFinished];
                NSLog(@"haha");
                if (complete) {
                    if (complete) {
                        complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
                    }
                }
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
    
  
}


@end
