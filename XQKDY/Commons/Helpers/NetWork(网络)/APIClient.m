//
//  APIClient.m
//  MVVM-demo
//
//  Created by shen_gh on 16/4/12.
//  Copyright © 2016年 申冠华. All rights reserved.
//

#import "APIClient.h"
#import "NetTool.h"
#import "Urls.h"

@implementation APIClient

//单例，每次只允许一次网络请求
+ (APIClient *)sharedManager{
    static APIClient *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //一次只允许一个请求
        if (manager==nil) {
            manager=[[APIClient alloc]init];
        }
    });
    return manager;
}

//获取首页list数据
- (void)netWorkGetHomePageListWithClassify:(NSString *)classify limit:(NSInteger)limit createDate:(NSString *)createDate type:(NSString *)type success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(limit),@"limit",classify,@"classify",createDate.length > 0 ? createDate:@"0",@"createDate",type.length > 0 ? type:@"",@"type",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kcollectionListUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取首页检索list数据
- (void)searchHomePageListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum keyWords:(NSString *)keyWords success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",keyWords,@"keyWords",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,ksearchcollectionListUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//删除首页list数据
- (void)deleteHomePageListWithCid:(NSString *)cid creatDate:(NSString *)creatDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:cid,@"articleId",creatDate.length > 0?creatDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kdeletecollecionUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取更新分类数据
- (void)updatekeywordswithKeyWords:(NSString *)keywords cid:(NSString *)cid success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",cid,@"cid",keywords,@"keyWords",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kupdatekeywordUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取分类数据列表
- (void)getkeywordslistsuccess:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kgetkeywordslistUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取分析数据列表
- (void)getsharelistWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kgetsharelistUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取我关注的数据列表
- (void)getmyconcernlistWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kgetusersfollowUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取我关注的数据列表
- (void)getotherconcernlistWithUsid:(NSString *)usid PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:usid,@"usid",@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kotheruserfollowUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取我关注的数据列表
- (void)getconcernmelistWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kgetfollowusersUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取关注他人的数据列表
- (void)getconcernotherlistWithUsid:(NSString *)usid PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:usid,@"usid",@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kfollowuserUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取笔记数据列表
- (void)getNoteListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum  success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kNoteListUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取笔记数据列表
- (void)getSuggestListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum lastTime:(NSString *)lastTime isRecommend:(NSString *)isRecommend startTime:(NSString *)startTime recommendTime:(NSString *)recommendTime success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",lastTime,@"lastTime",startTime,@"startTime",isRecommend,@"isRecommend",recommendTime,@"recommendTime",nil];
    
    NSLog(@"~~~~~~~~~dic:%@",parmDic);
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kNoteListUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



//删除笔记list数据
- (void)deleteNoteWithPid:(NSString *)pid  createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:pid,@"articleId",createDate,@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kdeleteNoteUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取笔记数据列表
- (void)getMineNoteListWithPageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate classify:(NSString *)classify success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",type,@"type",createDate.length > 0 ?createDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",classify,@"classify",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,ksearchclassifyUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getMineNoteListWithPageSize:(NSInteger)pageSize uid:(NSString *)uid type:(NSString *)type createDate:(NSString *)createDate classify:(NSString *)classify success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",uid,@"uid",type,@"type",createDate.length > 0 ?createDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",classify,@"classify",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,ksearchclassifyUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取笔记数据列表
- (void)getMineNoteListWithPageSize:(NSInteger)pageSize type:(NSString *)type creatDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",type,@"type",createDate.length > 0?createDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kmyDetailUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//获取笔记数据列表
- (void)getStatementListWithUid:(NSString *)uid PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",@(pageNum),@"page",uid,@"uid",[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,knotestatementlistUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取笔记数据列表
- (void)getMineNoteListWithKeyWords:(NSString *)keyWords  PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:keyWords,@"keyWords",@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,ksearchclassifyUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取搜索数据列表
- (void)searchlistWithTitle:(NSString *)title PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:title,@"title",@(pageSize),@"limit",@(pageNum),@"page",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kSearchListUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取我的推荐数据列表
- (void)getMyNoteListWithPageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",type,@"type",createDate.length > 0?createDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kmynotelistUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//删除我的笔记list数据
- (void)deleteMyNoteWithPid:(NSString *)pid success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:pid,@"pid",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kdeletemynoteUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//删除笔记list数据
- (void)loadMineNumbersuccess:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kgetmypagenumUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取他人数据
- (void)getOthersWithFid:(NSString *)fid PageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:fid,@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",@(pageSize),@"limit",type,@"type",createDate.length > 0?createDate:@"0",@"createDate",@"全部便签",@"classify",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kmynotelistUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取我的消息列表
- (void)getMyMessageListWithPageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",type,@"type",createDate.length > 0?createDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,knotificationUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//获取我的收益列表
- (void)getMyMoneyWithPageSize:(NSInteger)pageSize type:(NSString * )type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parmDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageSize),@"limit",type,@"type",createDate.length > 0 ?createDate:@"0",@"createDate",[[NSUserDefaults standardUserDefaults] valueForKey:kUserID],@"uid",
                           [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken],@"accessToken",nil];
    
    [[NetTool shareManager] httpPOSTRequest:[NSString stringWithFormat:@"%@%@",kbaseUrl,kamountListUrl] withParameter:parmDic success:^(Response *response) {
        success(response);
        NSLog(@"~~~~~~~~response:%@",response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
