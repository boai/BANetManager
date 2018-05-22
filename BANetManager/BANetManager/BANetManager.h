
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 * 简书    : http://www.jianshu.com/users/95c9800fdf47/latest_articles
 * 简书专题 : http://www.jianshu.com/collection/072d578bf782
 
 *********************************************************************************
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define BANetManagerShare [BANetManager sharedBANetManager]

#define BAWeak  __weak __typeof(self) weakSelf = self

/*! 过期属性或方法名提醒 */
#define BANetManagerDeprecated(instead) __deprecated_msg(instead)


/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, BANetworkStatus)
{
    /*! 未知网络 */
    BANetworkStatusUnknown           = 0,
    /*! 没有网络 */
    BANetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    BANetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    BANetworkStatusReachableViaWiFi
};

/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, BAHttpRequestType)
{
    /*! get请求 */
    BAHttpRequestTypeGet = 0,
    /*! post请求 */
    BAHttpRequestTypePost,
    /*! put请求 */
    BAHttpRequestTypePut,
    /*! delete请求 */
    BAHttpRequestTypeDelete
};

typedef NS_ENUM(NSUInteger, BAHttpRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    BAHttpRequestSerializerJSON,
    /** 设置请求数据为HTTP格式*/
    BAHttpRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, BAHttpResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    BAHttpResponseSerializerJSON,
    /** 设置响应数据为HTTP格式*/
    BAHttpResponseSerializerHTTP,
};

/*! 实时监测网络状态的 block */
typedef void(^BANetworkStatusBlock)(BANetworkStatus status);

/*! 定义请求成功的 block */
typedef void( ^ BAResponseSuccessBlock)(id response);
/*! 定义请求失败的 block */
typedef void( ^ BAResponseFailBlock)(NSError *error);

/*! 定义上传进度 block */
typedef void( ^ BAUploadProgressBlock)(int64_t bytesProgress,
int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ BADownloadProgressBlock)(int64_t bytesProgress,
int64_t totalBytesProgress);

/*!
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask BAURLSessionTask;

@class BADataEntity;

@interface BANetManager : NSObject

/**
 创建的请求的超时间隔（以秒为单位），此设置为全局统一设置一次即可，默认超时时间间隔为30秒。
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 设置网络请求参数的格式，此设置为全局统一设置一次即可，默认：BAHttpRequestSerializerJSON
 */
@property (nonatomic, assign) BAHttpRequestSerializer requestSerializer;

/**
 设置服务器响应数据格式，此设置为全局统一设置一次即可，默认：BAHttpResponseSerializerJSON
 */
@property (nonatomic, assign) BAHttpResponseSerializer responseSerializer;

/**
 自定义请求头：httpHeaderField
 */
@property(nonatomic, strong) NSDictionary *httpHeaderFieldDictionary;

/**
 将传入 的 string 参数序列化
 */
@property(nonatomic, assign) BOOL isSetQueryStringSerialization;

/**
 是否开启 log 打印，默认不开启
 */
@property(nonatomic, assign) BOOL isOpenLog;

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类BANetManager单例
 */
+ (instancetype)sharedBANetManager;


#pragma mark - 网络请求的类方法 --- get / post / put / delete

/**
 网络请求的实例方法 get

 @param entity 请求信息载体
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度回调
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_GETWithEntity:(BADataEntity *)entity
                                  successBlock:(BAResponseSuccessBlock)successBlock
                                  failureBlock:(BAResponseFailBlock)failureBlock
                                 progressBlock:(BADownloadProgressBlock)progressBlock;

/**
 网络请求的实例方法 post

 @param entity 请求信息载体
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_POSTWithEntity:(BADataEntity *)entity
                                   successBlock:(BAResponseSuccessBlock)successBlock
                                   failureBlock:(BAResponseFailBlock)failureBlock
                                  progressBlock:(BADownloadProgressBlock)progressBlock;

/**
 网络请求的实例方法 put
 
 @param entity 请求信息载体
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_PUTWithEntity:(BADataEntity *)entity
                                  successBlock:(BAResponseSuccessBlock)successBlock
                                  failureBlock:(BAResponseFailBlock)failureBlock
                                 progressBlock:(BADownloadProgressBlock)progressBlock;

/**
 网络请求的实例方法 delete
 
 @param entity 请求信息载体
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_DELETEWithEntity:(BADataEntity *)entity
                                     successBlock:(BAResponseSuccessBlock)successBlock
                                     failureBlock:(BAResponseFailBlock)failureBlock
                                    progressBlock:(BADownloadProgressBlock)progressBlock;

/**
 上传图片(多图)
 
 @param entity 请求信息载体
 @param successBlock 上传成功的回调
 @param failureBlock 上传失败的回调
 @param progressBlock 上传进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_uploadImageWithEntity:(BADataEntity *)entity
                                  successBlock:(BAResponseSuccessBlock)successBlock
                                   failurBlock:(BAResponseFailBlock)failureBlock
                                 progressBlock:(BAUploadProgressBlock)progressBlock;

/**
 视频上传
 
 @param entity 请求信息载体
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 @param progressBlock 上传的进度
 */
+ (void)ba_uploadVideoWithEntity:(BADataEntity *)entity
                    successBlock:(BAResponseSuccessBlock)successBlock
                    failureBlock:(BAResponseFailBlock)failureBlock
                   progressBlock:(BAUploadProgressBlock)progressBlock;

/**
 文件下载
 
 @param entity 请求信息载体
 @param successBlock 下载文件成功的回调
 @param failureBlock 下载文件失败的回调
 @param progressBlock 下载文件的进度显示
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_downLoadFileWithEntity:(BADataEntity *)entity
                                   successBlock:(BAResponseSuccessBlock)successBlock
                                   failureBlock:(BAResponseFailBlock)failureBlock
                                  progressBlock:(BADownloadProgressBlock)progressBlock;

/**
 文件上传
 
 @param entity 请求信息载体
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 @param progressBlock progressBlock description
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_uploadFileWithWithEntity:(BADataEntity *)entity
                                     successBlock:(BAResponseSuccessBlock)successBlock
                                     failureBlock:(BAResponseFailBlock)failureBlock
                                    progressBlock:(BAUploadProgressBlock)progressBlock;


#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)ba_startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus;

#pragma mark - 自定义请求头
/**
 *  自定义请求头
 */
+ (void)ba_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey;

/**
 删除所有请求头
 */
+ (void)ba_clearAuthorizationHeader;

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)ba_cancelAllRequest;

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)ba_cancelRequestWithURL:(NSString *)URL;

/**
 清空缓存：此方法可能会阻止调用线程，直到文件删除完成。
 */
- (void)ba_clearAllHttpCache;

@end

#pragma mark - 过期方法 网络请求的类方法 --- get / post / put / delete
// /**
// 网络请求的实例方法 get
//
// @param urlString 请求的地址
// @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
// @param parameters 请求的参数
// @param successBlock 请求成功的回调
// @param failureBlock 请求失败的回调
// @param progressBlock 进度
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_request_GETWithUrlString:(NSString *)urlString
//isNeedCache:(BOOL)isNeedCache
//parameters:(id)parameters
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BADownloadProgressBlock)progressBlock;
//
///**
// 网络请求的实例方法 post
//
// @param urlString 请求的地址
// @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
// @param parameters 请求的参数
// @param successBlock 请求成功的回调
// @param failureBlock 请求失败的回调
// @param progressBlock 进度
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_request_POSTWithUrlString:(NSString *)urlString
//isNeedCache:(BOOL)isNeedCache
//parameters:(id)parameters
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BADownloadProgressBlock)progressBlock;
//
///**
// 网络请求的实例方法 put
//
// @param urlString 请求的地址
// @param parameters 请求的参数
// @param successBlock 请求成功的回调
// @param failureBlock 请求失败的回调
// @param progressBlock 进度
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_request_PUTWithUrlString:(NSString *)urlString
//parameters:(id)parameters
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BADownloadProgressBlock)progressBlock;
//
///**
// 网络请求的实例方法 delete
//
// @param urlString 请求的地址
// @param parameters 请求的参数
// @param successBlock 请求成功的回调
// @param failureBlock 请求失败的回调
// @param progressBlock 进度
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_request_DELETEWithUrlString:(NSString *)urlString
//parameters:(id)parameters
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BADownloadProgressBlock)progressBlock;
//
///**
// 上传图片(多图)
//
// @param urlString urlString description
// @param parameters 上传图片预留参数---视具体情况而定 可为空
// @param imageArray 上传的图片数组
// @param fileNames 上传的图片数组 fileName
// @param imageType 图片类型，如：png、jpg、gif
// @param imageScale 图片压缩比率（0~1.0）
// @param successBlock 上传成功的回调
// @param failureBlock 上传失败的回调
// @param progressBlock 上传进度
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_uploadImageWithUrlString:(NSString *)urlString
//parameters:(id)parameters
//imageArray:(NSArray *)imageArray
//fileNames:(NSArray <NSString *>*)fileNames
//imageType:(NSString *)imageType
//imageScale:(CGFloat)imageScale
//successBlock:(BAResponseSuccessBlock)successBlock
//failurBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BAUploadProgressBlock)progressBlock;
//
///**
// 视频上传
//
// @param urlString 上传的url
// @param parameters 上传视频预留参数---视具体情况而定 可移除
// @param videoPath 上传视频的本地沙河路径
// @param successBlock 成功的回调
// @param failureBlock 失败的回调
// @param progressBlock 上传的进度
// */
//+ (void)ba_uploadVideoWithUrlString:(NSString *)urlString
//parameters:(id)parameters
//videoPath:(NSString *)videoPath
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BAUploadProgressBlock)progressBlock;
//
///**
// 文件下载
//
// @param urlString 请求的url
// @param parameters 文件下载预留参数---视具体情况而定 可移除
// @param savePath 下载文件保存路径
// @param successBlock 下载文件成功的回调
// @param failureBlock 下载文件失败的回调
// @param progressBlock 下载文件的进度显示
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString
//parameters:(id)parameters
//savaPath:(NSString *)savePath
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BADownloadProgressBlock)progressBlock;
//
///**
// 文件上传
//
// @param urlString urlString description
// @param parameters parameters description
// @param fileName fileName description
// @param filePath filePath description
// @param successBlock successBlock description
// @param failureBlock failureBlock description
// @param progressBlock progressBlock description
// @return BAURLSessionTask
// */
//+ (BAURLSessionTask *)ba_uploadFileWithUrlString:(NSString *)urlString
//parameters:(id)parameters
//fileName:(NSString *)fileName
//filePath:(NSString *)filePath
//successBlock:(BAResponseSuccessBlock)successBlock
//failureBlock:(BAResponseFailBlock)failureBlock
//progressBlock:(BAUploadProgressBlock)progressBlock;



