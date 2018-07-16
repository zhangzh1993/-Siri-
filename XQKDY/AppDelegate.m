//
//  AppDelegate.m
//  XQKDY
//
//  Created by 张正浩 on 2017/4/7.
//  Copyright © 2017年 张正浩. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseNavigation.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
#import <CoreLocation/CoreLocation.h>
#import "iflyMSC/IFlyMSC.h"

#define APPID_VALUE @"51f1e268"

@interface AppDelegate ()<CLLocationManagerDelegate>{
    
    NSString * _Strlatitude;//经度
    NSString * _Strlongitude;//纬度
    NSString * _nowTime;     //时间
}
/* 位置管理者 */
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Appid是应用的身份信息,具有唯一性,初始化时必须要传入Appid。
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    [IFlySpeechUtility createUtility:initString];
    
    //向微信注册
    [WXApi registerApp:kWXAPP_ID];
    
    //分享
    [ShareSDK registerApp:@"17731a0239d51"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformSubTypeQQFriend),
                            @(SSDKPlatformSubTypeQZone),
                            @(SSDKPlatformTypeAny)]
     
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:kWXAPP_ID
                                       appSecret:kWXAPP_SECRET];
                 break;

             default:
                 break;
         }
     }];

    
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:kUserID]) {
        [self rootViewController];
//    }
//    else
//    {
//        [self firstLogin];
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootViewController) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstLogin) name:@"LoginFailed" object:nil];
    // 1.创建位置管理者
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    //设置期望精度
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    //设置代理
    locationManager.delegate = self;
    //开启定位
    [locationManager startUpdatingLocation];
    return YES;
}
#pragma mark Corelocation delegate(定位成功)

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [manager stopUpdatingLocation];
    CLLocation * currentlocation  = [locations lastObject];
    NSDate *time = currentlocation.timestamp;
    //CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    NSLog(@"当前经纬度:%f---%f--%@",currentlocation.coordinate.latitude,currentlocation.coordinate.longitude,time);
    _Strlatitude = [NSString stringWithFormat:@"%f",currentlocation.coordinate.latitude];
    _Strlongitude = [NSString stringWithFormat:@"%f",currentlocation.coordinate.longitude];
    _nowTime = [NSString stringWithFormat:@"%lld",[DateTimeFormat longLongFromDate:time]];
    if (![_Strlatitude  isEqual: @""] || ![_Strlongitude  isEqual: @""]) {
        return;
    }
    [self postLocation];
    
}

-(void)postLocation{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 因为传递过去和接收回来的数据都不是json类型的，所以在这里要设置为AFHTTPRequestSerializer和AFHTTPResponseSerializer
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSString * urlString2  = [NSString stringWithFormat:@"%@%@",kbaseUrl,kpostLocationUrl];
    
    NSDictionary *dic1 = @{ @"lat":_Strlatitude,
                            @"lon":_Strlongitude,
                            @"time":_nowTime,};
    NSMutableArray *arr = [NSMutableArray arrayWithObject:dic1];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary * dic2 = @{
                            @"accessToken":[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],
                            @"records":jsonStr,
                            };
    
    NSLog(@"~~~~~~urlString:%@",urlString2);
    NSLog(@"~~~~~~dic:%@",dic2);
    [manager POST:urlString2 parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"~~~~~~~response:%@",response);
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([[json valueForKey:@"code"] intValue]==10000) {
            
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    


}
// 设置当前rootViewController
- (void)rootViewController {
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController=[storyBoard instantiateInitialViewController];
    
}
// 第一次登录
- (void)firstLogin {
   
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
