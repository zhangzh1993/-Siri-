//
//  Macros.h
//  懒人商城
//
//  Created by 张正浩 on 15/9/8.
//  Copyright (c) 2015年 张正浩. All rights reserved.
//

@interface Macros : NSObject
/*--------------------------------- 设备 -------------------------------------*/

/// 设备的高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

/// 设备的宽度
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

/// 底部导航栏高度
#define kScreenTabBarHeight 49

/// 当前设备为 iPhone4 4s
#define iPhone4 (kScreenHeight == 480 ? YES : NO)

/// 当前设备为 iPhone5 5s
#define iPhone5 (kScreenHeight == 568 ? YES : NO)

/// 当前设备为 iPhone6
#define iPhone6 (kScreenHeight == 667 ? YES : NO)

/// 当前设备为 iPhone6 Plus
#define iPhone6Plus (kScreenHeight == 736 ? YES : NO)

//比例适配
#define widthRate kScreenWidth/320

#define KImageMaxKB     600.0f  //标记图片最大内存大小为600K

#define IOS7 ([UIDevice currentDevice].systemVersion.integerValue >= 7)

#define  timeSec (([[VPKCUtils doDevicePlatform] isEqualToString:@"iPhone 4"] || [[VPKCUtils doDevicePlatform] isEqualToString:@"iPhone 4S"]) ? 30:20)

/*--------------------------------- 颜色 -------------------------------------*/
// RGBA
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

// RGB
#define RGB(r,g,b) RGBA(r,g,b,1)

/*-------------------------------- 方法简写 ----------------------------------*/

/// 用于不需要回调的一个按钮的 AlertView
#define kShowAlertView(title,msg,buttonText) \
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:buttonText otherButtonTitles:nil];\
\
[alert show];\
}


#define XNColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define XNWindowWidth        ([[UIScreen mainScreen] bounds].size.width)

#define XNWindowHeight       ([[UIScreen mainScreen] bounds].size.height)

#define XNFont(font)         [UIFont systemFontOfSize:(font)]

#define XNWidth_Scale        [UIScreen mainScreen].bounds.size.width/375.0f

// 数据库地址
#define DATABASE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kidcares.sqlite"]


#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 1.Dock上条目的尺寸
#define kDockItemW 100
#define kDockItemH 80


// 顶部菜单项的宽高
#define kTopMenuItemW 130
#define kTopMenuItemH 44

// 底部菜单项的宽高
#define kBottomMenuItemW 130
#define kBottomMenuItemH 70

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif



// 3.通知名称
// 城市改变的通知
#define kCityChangeNote @"city_change"
// 区域改变的通知
#define kDistrictChangeNote @"district_change"
// 分类改变的通知
#define kCategoryChangeNote @"category_change"
// 排序改变的通知
#define kOrderChangeNote @"order_change"
// 收藏改变的通知
#define kCollectChangeNote @"collect_change"

// 城市的key
#define kCityKey @"city"
#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];

// 4.全局背景色
#define kGlobalBg RGBA(255,126,36,1)

// 5.默认的动画时间
#define kDefaultAnimDuration 0.3

// 6.固定的字符串
#define kAllCategory @"全部分类"
#define kAllDistrict @"全部商区"
#define kAll @"全部"
//// 微信key
#define kWXAPP_ID @"wxb7bf35c53193e26e"
#define kWXAPP_SECRET @"bb493057d8f3487847b22edc6529154c"

//微信支付成功
#define kwxPaySuccess @"WXPaySuccess"


#define kCity @"深圳"

/**
 *  API
 *  https://dev-platformapi.roistar.net
 *  https://dev-rgbox-api.roistar.net
 */


#define kbaseUrl @"" //济南Url
#define kloginrUrl @"/login"
#define kuseRegisterUrl @"/register"//登录
//首页数据
#define kgetcountUrl @"/promotedproduct/getcount"//发布数
#define kindexcountUrl @"/promotedorder/indexcount"//其他数字
#define kindexrankUrl @"/promotedorder/indexrank"//排行榜数字
#define kcustomerinfogetcountUrl @"/customerinfo/getcount"//粉丝数字
#define kexpressordercollectUrl @"/expressorder/collect"//批量交接
#define ktosignsUrl @"/expressorder/tosigns"//批量签收
#define kexpressshopbuildUrl @"/expressshop/build"//创建门店
#define kexpressshopgetallUrl @"/expressshop/getall"//门店列表
#define kexpresscabinetbuildUrl @"/expresscabinet/build"//新增柜子
#define kexpressshoptofixUrl @"/expressshop/tofix"//修改门店
#define ktoverifyUrl @"/expressshop/toverify"//关闭门店
#define kresendsmssignUrl @"/customerrecord/resendsmssign"//重发短信
#define ktakeselfUrl @"/customerrecord/takeself"//自提
#define ksearchUrl @"/search/order"//搜索
#define kamountshopUrl @"/customerrecord/amountshop"//自提数据
#define kgetlistundelayUrl @"/customerrecord/getlistundelay"//自提列表
#define kcustomerinfogetallUrl @"/customerinfo/getall"//粉丝列表
#define kcustomerinfobuildUrl @"/customerinfo/build"//新增粉丝
#define kgetlistdelayUrl @"/customerrecord/getlistdelay"//滞留列表
#define kgetservicesUrl @"/customerrecord/getservices"//自提记录
#define ksearchlistcodeUrl @"/customerrecord/searchlistcode"//搜索接口
#define kcustomerinfogetoneUrl @"/customerinfo/getone"//获取画像
#define kexpresscabinetUrl @"/expresscabinet/getall"//获取柜子
#define kaddlabelUrl @"/customerinfo/addlabel"//添加时间标签
#define ktoaddUrl @"/labelgroup/toadd"//添加标签
#define kcustomerinfoUrl @"/customerinfo/rmlabel"//删除标签
#define klabellibUrl @"/labellib/todel"//团队标签删除
#define kexpresscabinettodelUrl @"/expresscabinet/todel"//删除柜子
#define kgetrecordUrl @"/labelgroup/getrecord"//查找标签
#define klabelgrouptodelUrl @"/labelgroup/todel"//删除标签
#define kdelrecordUrl @"/customerinfo/delrecord"//删除自定义标签;
#define kaddrecordsUrl @"/customerinfo/addrecords"//批量添加标签
#define kexpressamountUrl @"/customerinfo/expressamount"//派件数字
#define kexpresslistUrl @"/customerinfo/expresslist"//派件列表
#define kpromotedorderlistUrl @"/customerinfo/promotedorderlist"//闪购列表
#define kpromotedorderamountUrl @"/customerinfo/promotedorderamount"//闪购数字
#define kcustomerrecordamountcustomerUrl @"/customerrecord/amountcustomer"//自提数量
#define kcgetmodelsignUrl @"/sms/getmodelsign"//获取短信模版
#define kmicroauthorUrl @"/microauthor/getlist"//闪购数字
#define kgetallsigned @"/expressorder/getallsigned"//获取票件统计
#define kgetlistfinishedUrl @"/expressorder/getlistfinished"//票件统计
#define kmicroarticleUrl @"/microarticle/getlist"//微书列表
#define kgettypeUrl @"/microarticle/gettype"//获取微书type
#define kmicroarticletoreadUrl @"/microarticle/toread"//阅读文章
#define kmicrobutlermissionUrl @"/microbutlermission/getlist"//获取待处理列表
#define kmicrobutlermissionbuildUrl @"/microbutlermission/build"//创建待处理
#define kmicrobutlermissioncompletesUrl @"/microbutlermission/completes"//批量操作
#define krecorddaygetdatasUrl @"/recordday/getdatas"//掌柜接口
#define kmicrobutlerstatementUrl @"/microbutlerstatement/getinfomon"//账单明细
#define kmicrobutlerApplyUrl @"/microbutlerApply/apply"//提现
#define kchargepaygetsignUrl @"/chargepay/getsign"//充值
#define ksendsmssignUrl   @"/customerrecord/sendsmssign"//发短信
#define klabellibgetlistUrl @"/labellib/getlist"//获取标签
#define klabellibtoaddUrl @"/labellib/toadd"//添加团队标签
#define kexpressorderUrl @"/expressorder/signdesc"//异常标签
#define kcustomerinfotofixUrl @"/customerinfo/tofix"//修改粉丝信息
#define ksearchcustomerurl @"/customerinfo/searchcustomer"//粉丝筛选
#define kcustomerinfosearchmenuUrl @"/customerinfo/searchmenu"//搜索菜单
#define kpostLocationUrl @"/boygps/builds"//上传用户位置信息
#define kpointMarkUrl @"/customerinfo/pointmark"//评分





#define kcollectionUrl @"/create/collection"//创建收藏
#define kgetphonecodefixUrl @"/registercode"//获取验证码
#define kfixpwdUrl @"/change-password"//修改密码
#define kuserinfoUrl @"/express-member/get-user-info"//获取详情
#define khomestatisticsurl @"/express-order/home-statistics"//首页数字
#define khomeslisturl @"/get-store-list"//首页数字
#define kgetexpresslistUrl @"/get-express-list"//快递详情

#define kexpressaffirmUrl @"/express-order/express-affirm"//确认免单
#define kgetbilldateUrl @"/express-member/get-bill-date"//账单日期列表
#define kgetbillUrl @"/express-member/bill"//账单
#define kchargepayUrl @"/chargepay"//支付掉起
#define kgetchargerecordUrl @"/express-member/get-charge-record"//充值记录
#define kchargerecordlistUrl @"/chargerecord/getlist"//充值记录

#define kupdateNoteUrl @"/v2/collection/update/statement"//更新笔记
#define kcustomizeUpdateUrl @"/v2/collection/update/customizeUpdate"//写字板更新
#define kdeletecollecionUrl @"/v2/collection/delete"//删除
#define kcollectionListUrl @"/v2/collection/detail"//获取首页数据
#define ksearchClassifyUrl @"/v2/search/classify"//搜索笔记
#define ksearchcollectionListUrl @"/search/keywords"//获取首页检索数据
#define kupdatekeywordUrl @"/update/keywords"//更新关键字
#define kcreatClassifyUrl @"/v2/collection/classify/create"//创建分类
#define kclassifyUpdateUrl @"/v2/collection//classify/update"//更新分类
#define kclassifyDeleteUrl @"/v2/collection/classify/delete"//删除分类
#define kgetkeywordslistUrl @"/users/getuserkeywords"//获取keywords列表
#define kclassifyUrl @"/v2/collection/classify"
#define kstatementclassUrl @"/v2/other/get/statementclass/num"//获取商品分类
#define kupdatekeywordsUrl @"/users/updatekeywords"//更新分类
#define kuploadimageUrl @"/create/share"//上传图片
#define kgetsharelistUrl @"/list/shareList"//分享列表
#define kgetusersfollowUrl @"/relation/getusersfollow"//我关注的
#define kgetfollowusersUrl @"/relation/getfollowusers"//关注我的
#define kotheruserfollowUrl @"/other/getotheruserrelation/userfollow"//关注的人
#define kfollowuserUrl @"/other/getotheruserrelation/followuser"//他人关注
#define kaddfollowUrl @"/relation/addfollow"//添加关注
#define kgetallfollowUrl @"/relation/getallfollowphone"//获取所有已关注
#define kdeletefollowUrl @"/relation/deletefollow"//取消关注
#define kuodatePushUrl @"/v2/recommend/create"//转推
#define kNoteListUrl @"/v2/recommend/list"//笔记列表
#define kNoteDetailUrl @"/v2/content"//笔记详情
#define kNotePushUrl @"/v2/recommend/like"//笔记转推
#define kNoteCollectionUrl @"/v2/recommend/create/collection"//笔记收藏
#define kotherNoteCollectionUrl @"/create/othercollection"//他人笔记收藏
#define kdeleteNoteUrl @"/v2/recommend/delete"//删除笔记
#define knotestatementUrl @"/create/notestatement"//便签收藏
#define kgetstatementnumUrl @"/other/getstatementnum"//便签收藏数量
#define knotestatementlistUrl @"/list/notestatementlist"//我的笔记列表
#define ksavestatementUrl @"/v2/collection/update/savestatement"//保存至我的笔记
#define knotelistcontentUrl @"/content/notelistcontent"//我的列表原文链接
#define kdeletenotestatementUrl @"/v2/my/update/delete"//删除笔记
#define kSearchListUrl @"/v2/search/title"//搜索列表
#define kmynotelistUrl @"/v2/my/recommend"//我的推荐
#define kdeletemynoteUrl @"/delete/mynote"//删除我的推荐
#define kgetmypagenumUrl @"/other/getmypagenum"//我的数字
#define kmyDetailUrl @"/v2/my/detail"//个人资料
#define kupdateuserinfoUrl @"/update/userinfo"//更新个人信息
#define kgetuserpageinfoUrl @"/other/getuserpage/list"//获取其他用户数据
#define kgetotherinfoUrl @"/v2/other/users/detail"//获取他人数字
#define kgetclassifynumUrl @"/other/getclassifynum"//推荐分类
#define ksearchclassifyUrl @"/v2/search/classify"//筛选便签
#define kaddbrowsenumUrl @"/update/addbrowsenum"//更新推荐出来数字
#define kisregisterUrl @"/relation/isregister"//看哪些用户已经注册了
#define ksearchPhoneUrl @"/search/phone"//搜索好友
#define kaddsharenumUrl @"/v2/other/update/share"//分享出去数字加1
#define knotificationUrl @"/v2/notification/list"//消息列表
#define kgetsomenotenumUrl @"/v2/recommend/refresh"//刷新某条数据
#define kamountListUrl @"/v2/amount/list"//我的收益
#define kamountCountUrl @"/v2/amount/count"//获取总金额
#define kamountCashUrl @"/v2/amount/cash"//提现金额
#define ksharetollUrl @"/v2/other/share/toll"//分享收费
#define kmoneyDetailUrl @"/v2/amount/detail"//获取某篇文章的支付详情
/**
 *  参数
 */
#define kUserID @"uid"//用户ID
#define kBID @"bid"//业务ID
#define kUserName @"nickname"//用户name
#define kcompanyName @"companyname"//用户name
#define kbossName @"bossname"//用户name
#define kSex @"sex"
#define kSignature @"signature"
#define kphoneNum @"phone"
#define kAccessToken @"accessToken"//token
#define kAccountPay @"accountAlipay"//支付宝账户
#define kHeadPicUrl @"PicUrl"
#define kpicUrl @"picUrl"//头像url
#define kstoreName @"storeName"//商店名称
#define kQQNumber @"QQNumber"//微信号
#define kAlipay @"Alipay"//支付宝账户
#define kAddress @"address"//微信号
#define kareaCode @"areaCode"//微信号
#define klongitude @"longitude"//经度
#define klatitude @"latitude"//经度
#define kstartTime @"startTime"//开业时间
#define kcloseTime @"closeTime"//关店时间
#define kloactionStr @"loactionStr"//定位位置
#define kplaceStr @"placeStr"//区号
#define kareaId @"areaId"//区号
@end
