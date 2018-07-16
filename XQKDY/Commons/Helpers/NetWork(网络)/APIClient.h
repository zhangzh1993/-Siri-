//
//  APIClient.h
//  MVVM-demo
//
//  Created by shen_gh on 16/4/12.
//  Copyright © 2016年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface APIClient : NSObject

//单例自行实例化
+ (APIClient *)sharedManager;


/**
 *  获取首页list数据
 *
 *  @param pageSize 每页数据量
 *  @param pageNum  页号
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)netWorkGetHomePageListWithClassify:(NSString *)classify limit:(NSInteger)limit createDate:(NSString *)createDate type:(NSString *)type success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)updatekeywordswithKeyWords:(NSString *)keywords cid:(NSString *)cid  success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)searchHomePageListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum keyWords:(NSString *)keyWords success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)deleteHomePageListWithCid:(NSString *)cid creatDate:(NSString *)creatDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getkeywordslistsuccess:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getsharelistWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getmyconcernlistWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getconcernmelistWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getNoteListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)deleteNoteWithPid:(NSString *)pid  createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMineNoteListWithPageSize:(NSInteger)pageSize uid:(NSString *)uid type:(NSString *)type createDate:(NSString *)createDate classify:(NSString *)classify success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMineNoteListWithPageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate classify:(NSString *)classify success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMineNoteListWithPageSize:(NSInteger)pageSize type:(NSString *)type creatDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)searchlistWithTitle:(NSString *)title PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMyNoteListWithPageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;


- (void)deleteMyNoteWithPid:(NSString *)pid success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)loadMineNumbersuccess:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getOthersWithFid:(NSString *)fid PageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMineNoteListWithKeyWords:(NSString *)keyWords  PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getSuggestListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum lastTime:(NSString *)lastTime isRecommend:(NSString *)isRecommend startTime:(NSString *)startTime recommendTime:(NSString *)recommendTime success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMyMessageListWithPageSize:(NSInteger)pageSize type:(NSString *)type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getotherconcernlistWithUsid:(NSString *)usid PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getconcernotherlistWithUsid:(NSString *)usid PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getStatementListWithUid:(NSString *)uid PageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

- (void)getMyMoneyWithPageSize:(NSInteger)pageSize type:(NSString * )type createDate:(NSString *)createDate success:(void (^)(Response *respone))success failure:(void(^)(NSError *error))failure;

@end
