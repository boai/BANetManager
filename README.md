# BANetManager
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/cocoapods/v/BANetManager.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BANetManager.svg
)  [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)
[![codecov.io](https://codecov.io/github/BAHome/BANetManager/branch/master/graphs/badge.svg)](https://codecov.io/github/BAHome/BANetManager)


## 1、功能及简介
* 1、集成 get / post / put / delete 等常用请求方式的封装 <br>
* 2、集成单图/多图上传，让图片上传更简单，自带压缩处理
* 3、集成视频上传/下载，和文件下载，让视频的上传下载更方便，支持异步下载【已测试多个项目通过】
* 4、集成网络监测，让你实时监测你的宝贝APP的网络状态【已经测试通过】
* 5、新增 https 请求参数自定义：requestSerializer、responseSerializer、请求头等的配置
* 6、自定义 CA 证书 和 HTTPS 请求配置，只需把证书导入项目目录即可
* 7、如果使用PHP后台，后台不会对接此接口的话，博爱已经为你们量身定做了PHP后台接口，你们只需要把文件夹中的 postdynamic.php 文件发送给你们的PHP后台同事，他们就知道了，里面都有详细说明！
* 8、新增 YYCache 缓存处理，有缓存开关，随时缓存
* 9、新增自定义：超时设置，取消单个网络请求和取消所有网络请求
* 10、史上最全的 AFN 请求 NSLog 打印，详见 demo 控制台打印结果
* 11、新增 清除 请求头<br>
* 12、新增 文件上传<br>
* 13、优化多图上传<br>
* 14、控制台打印 debug 状态下显示中文<br>
* 15、新增 默认请求头：@"application/x-www-form-urlencoded" <br>
* 16、新增 删除所有缓存的方法，可以自由删除当前的所有缓存！<br>
* 17、新增单元测试

 
## 2、图片示例
![BANetManager1.png](https://github.com/BAHome/BANetManager/blob/master/Images/BANetManager1.png)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BANetManager.svg?style=flat)】： <br>
 `pod 'BANetManager'`  <br>
如果发现 `pod search BANetManager` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BANetManager
* 2、文件夹拖入：下载demo，把 BANetManager 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BANetManager.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BANetManager](https://github.com/BAHome/BANetManager)<br>

## 4、BANetManager 的类结构及 demo 示例
![BANetManager.png](https://github.com/BAHome/BANetManager/blob/master/Images/BANetManager.png)

### BANetManager.h
```
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
```
### demo 示例
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"BANetManager";
    
    /*! 网络状态实时监测可以使用 block 回调，也可以使用单独方法判断 */
    [self ba_netType];
    
}

#pragma mark - 网络类型判断
- (void)ba_netType
{
//    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 0:
            {
                msg = @"未知网络";
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
            case 1:
            {
                msg = @"没有网络";
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
            case 2:
            {
                msg = @"您的网络类型为：手机 3G/4G 网络";
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
            case 3:
            {
                msg = @"您的网络类型为：wifi 网络";
                /*! wifi 网络下请求网络：可以在父类写此方法，具体使用demo，详见：https://github.com/boai/BABaseProject */
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - get
- (IBAction)getData:(UIButton *)sender
{
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = url5;
    entity.needCache = YES;
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSLog(@"get 请求数据结果： *** %@", response);
        NSString *msg = [NSString stringWithFormat:@"get 请求数据结果：%@", response];
        BAKit_ShowAlertWithMsg(msg);
    } failureBlock:^(NSError *error) {
        
    } progressBlock:nil];
}

#pragma mark - post
- (IBAction)postData:(UIButton *)sender
{
    [sender setTitle:@"post" forState:UIControlStateNormal];
    // 自定义超时设置
    BANetManagerShare.timeoutInterval = 15;
    
    // 自定义添加请求头
//    NSDictionary *headerDict = @{@"Accept":@"application/json", @"Accept-Encoding":@"gzip", @"charset":@"utf-8"};
//    BANetManagerShare.httpHeaderFieldDictionary = headerDict;
    
    // 自定义更改 requestSerializer
//        BANetManagerShare.requestSerializer = BAHttpRequestSerializerHTTP;
    // 自定义更改 responseSerializer
//        BANetManagerShare.responseSerializer = BAHttpRequestSerializerHTTP;
    
    // 清楚当前所有请求头
//    [BANetManager ba_clearAuthorizationHeader];
    
    
//    NSString *url = @"http://115.29.201.135/mobile/mobileapi.php";
//    NSString *parameters = @"sAp3OxNlYMZZa7OlRi2TwguoTtwNwwFwOo5k8LL3ERtcTbAvGPhZ5yUWiiIJeXx2WjYlnMU1nFOoi2JSKJDINW62lcM9DB9XDdZQACnY60g=";
//    int page = 1;
    NSDictionary *parameters = @{
                           @"txtusername":@"13651789999",
                           @"txtpassword":@"123456"
                           };
//    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(page).stringValue, @"page", @"10", @"per_page", nil];;
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = url6;
    entity.needCache = NO;
    entity.parameters = parameters;
    
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSLog(@"post 请求数据结果： *** %@", response);
        self.uploadLabel.text = @"上传完成";
        [sender setTitle:@"上传完成" forState:UIControlStateNormal];
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        /*! 封装方法里已经回到主线程，所有这里不用再调主线程了 */
        self.uploadLabel.text = [NSString stringWithFormat:@"上传进度：%.2lld%%",100 * bytesProgress/totalBytesProgress];
        [sender setTitle:@"上传中..." forState:UIControlStateNormal];
    }];
}

#pragma mark - 下载视频、图片
- (IBAction)downloadData:(UIButton *)sender
{
    UIButton *downloadBtn = (UIButton *)sender;
    NSString *path1 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/半塘.mp4"]];
    //    NSString *path2 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/image123.mp3"]];
    
    NSLog(@"路径：%@", path1);
    
    /*! 查找路径中是否存在"半塘.mp4"，是，返回真；否，返回假。 */
    //    BOOL result2 = [path1 hasSuffix:@"半塘.mp4"];
    //    NSLog(@"%d", result2);
    
    /*!
     下载前先判断该用户是否已经下载，目前用了两种方式：
     1、第一次下载完用变量保存，
     2、查找路径中是否包含改文件的名字
     如果下载完了，就不要再让用户下载，也可以添加alert的代理方法，增加用户的选择！
     */
    //    if (isFinishDownload || result2)
    //    {
    //        [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"您已经下载该视频！" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil] show];
    //        return;
    //    }
//    BAWeak;
    
    BAFileDataEntity *fileEntity = [BAFileDataEntity new];
    fileEntity.urlString = @"http://static.yizhibo.com/pc_live/static/video.swf?onPlay=YZB.play&onPause=YZB.pause&onSeek=YZB.seek&scid=pALRs7JBtTRU9TWy";
    fileEntity.filePath = path1;
    
    [BANetManager ba_downLoadFileWithEntity:fileEntity successBlock:^(id response) {
        NSLog(@"下载完成，路径为：%@", response);
        self.downloadLabel.text = @"下载完成";
        isFinishDownload = YES;
        [downloadBtn setTitle:@"下载完成" forState:UIControlStateNormal];
        [downloadBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        BAKit_ShowAlertWithMsg(@"视频下载完成！");
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        /*! 封装方法里已经回到主线程，所有这里不用再调主线程了 */
        self.downloadLabel.text = [NSString stringWithFormat:@"下载进度：%.2lld%%",100 * bytesProgress/totalBytesProgress];
        [downloadBtn setTitle:@"下载中..." forState:UIControlStateNormal];
    }];
}

#pragma mark - 上传图片
- (IBAction)uploadImageData:(UIButton *)sender
{
    /*!
     
     1、此上传图片单张、多图上传都经过几十个项目亲测可用，大家可以放心使用，使用过程中有问题，请加群：479663605 进行反馈，多谢！
     2、注意：如果使用PHP后台，后台不会对接此接口的话，博爱已经为你们量身定做了PHP后台接口，你们只需要把文件夹中的 postdynamic.php 文件发送给你们的PHP后台同事，他们就知道了，里面都有详细说明！
     */
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - 上传视频
- (IBAction)uploadVideoData:(UIButton *)sender
{
    /*!
     
     1、此上传视频都经过几十个项目亲测可用，大家可以放心使用，使用过程中有问题，请加群：479663605 进行反馈，多谢！
     2、此处只需要传URL 和 parameters就行了，具体压缩方法都已经做好处理！
     
     */
    BAFileDataEntity *videoEntity = [BAFileDataEntity new];
    
    [BANetManager ba_uploadVideoWithEntity:videoEntity successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - put 请求
- (IBAction)putData:(UIButton *)sender
{
    NSDictionary *dict = @{@"EquipmentType":@"iPhone", @"EquipmentGUID":@"b61df00d-87db-426f-bc5a-bc8fffa907db"};
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = @"http://120.76.245.240:8080/bda/resetPassword/?account=761463699@qq.com&password=q&OTP=634613";
    entity.parameters = dict;
    
    [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
        NSLog(@"*********00000 : %@", response);
    } failureBlock:^(NSError *error) {
        
    } progressBlock:nil];
}

#pragma mark - delete 请求
- (IBAction)deleteData:(UIButton *)sender
{
    BADataEntity *entity = [BADataEntity new];
    [BANetManager ba_request_DELETEWithEntity:entity successBlock:nil failureBlock:nil progressBlock:nil];
}

#pragma mark - 上传文件
- (IBAction)uploadFileButtonAction:(UIButton *)sender
{
    BAFileDataEntity *fileEntity = [BAFileDataEntity new];
    [BANetManager ba_uploadFileWithWithEntity:fileEntity successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

其他示例可下载 demo 查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
  
 最新更新时间：2018-05-22 【倒叙】<br>
 最新Version：【Version：2.3.10】<br>
 更新内容：<br>
 2.3.10.1、新增 属性【isOpenLog】（注意：是否开启 log 打印，默认不开启）
 2.3.10.2、优化部分代码
 
 最新更新时间：2018-04-16 【倒叙】<br>
 最新Version：【Version：2.3.9】<br>
 更新内容：<br>
 2.3.9.1、新增 isSetQueryStringSerialization 配置参数，可以将传入 的 string 参数序列化，使用方式：BANetManagerShare.isSetQueryStringSerialization = YES，详见【BANetManager.h】文件;<br>
 2.3.9.1、修复 【BANetManagerCache.m】文件中，【+ (NSString *)ba_cacheWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters】方法中 parameters 增加了字典的容错判断。
 
 最新更新时间：2017-11-20 【倒叙】<br>
 最新Version：【Version：2.3.8】<br>
 更新内容：<br>
 2.3.8.1、【方法替换】原传参方式为 id 类型，现在统一改为 BADataEntity 类型，具体参考 BADataEntity 类，如果更新发现较多错误，敬请谅解，可以恢复至上一版本【Version：2.3.6】，感谢[@北京-晋登科 大神](http://www.jianshu.com/u/1fc1bd217dc5) 的亲自操刀改版！<br>
 2.3.8.2、【方法替换】原图像上传方法传参 精简为 BADataEntity 类下的 BAImageDataEntity 类，具体参考 BAImageDataEntity 类，如果更新发现较多错误，敬请谅解，可以恢复至上一版本【Version：2.3.6】<br>
 2.3.8.3、【方法替换】原文件上传、下载方法传参 精简为 BADataEntity 类下的 BAFileDataEntity 类，具体参考 BAFileDataEntity 类，如果更新发现较多错误，敬请谅解，可以恢复至上一版本【Version：2.3.6】<br>
 2.3.8.4、【新增文件】新增 BAParameterEntity 文件夹，主要处理所有上传所需的参数等信息 <br>
 2.3.8.4、【新增文件】新增 BANetManager_Version.h 文件，主要处理所有版本更新内容等信息 <br>

 最新更新时间：2017-09-09 【倒叙】<br>
 最新Version：【Version：2.3.6】<br>
 更新内容：<br>
 2.3.6.1、更换 传参 类型为 id 类型，传参更自由！<br>
 
 最新更新时间：2017-08-18 【倒叙】<br>
 最新Version：【Version：2.3.5】<br>
 更新内容：<br>
 2.3.5.1、新增 删除所有缓存的方法，可以自由删除当前的所有缓存！<br>
 
 最新更新时间：2017-08-17 【倒叙】<br>
 最新Version：【Version：2.3.4】<br>
 更新内容：<br>
 2.3.4.1、控制台打印 debug 状态下显示中文<br>
 2.3.4.2、移除默认 requestSerializer 和 responseSerializer<br>
 2.3.4.3、新增 post 请求的进度提示<br>
 2.3.4.4、新增 默认请求头：@"application/x-www-form-urlencoded" <br>
 2.3.4.5、优化部分代码规范，给大家带来的不变，敬请谅解！<br>

 最新更新时间：2017-07-18 【倒叙】<br>
 最新Version：【Version：2.3.3】<br>
 更新内容：<br>
 2.3.3.1、新增 清除 请求头<br>
 2.3.3.2、新增 文件上传<br>
 2.3.3.3、优化多图上传<br>
 
 最新更新时间：2017-05-03 【倒叙】<br>
 最新Version：【Version：2.2.2】<br>
 更新内容：<br>
 2.2.1、优化方法名命名规范<br>
 2.2.2、优化网络状态实时监测 block 回调，去除多余设置，需要网络判断，直接调用block回调即可<br>
 2.2.3、新增 YYCache 缓存处理<br>
 2.2.4、新增自定义：超时设置<br>
 2.2.5、新增自定义：requestSerializer设置<br>
 2.2.6、新增自定义：responseSerializer设置<br>
 2.2.7、新增自定义：请求头设置<br>
 2.2.8、新增自定义 CA 证书 和 HTTPS 请求配置，只需把证书导入项目目录即可，无需设置<br>
 2.2.9、新增史上最全的 AFN 请求 NSLog 打印，详见 demo 控制台打印结果<br>
 2.2.10、新增 DEBUG 模式下的 NSLog 判断，release 下不会打印，请放心使用<br>
 2.2.11、如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据<br>
 2.2.12、由于新版本改动较大，原有方法命名可能有所改动，希望老用户见谅！<br>
 2.2.13、目前版本较稳定，稍后奉上 pod 版本！请大家耐心等待

 最新更新时间：2016-11-24 【倒叙】<br>
 最新Version：【Version：2.1】<br>
 更新内容：<br>
 2.1.1、优化方法名命名规范<br>
 2.1.2、新增网络状态实时监测 block 回调，新增单独网络监测 bool 返回，详见 demo<br>
 2.1.3、新增旧方法更新提示<br>
 2.1.4、优化各种注释<br>
 
 最新更新时间：2016-11-17<br>
 最新Version：【Version：2.0】<br>
 更新内容：<br>
 2.0.1、优化方法名命名规范<br>
 2.0.2、新增部分注释<br>
 2.0.3、视频上传方法对接，目前有很多项目对接成功

## 6、bug 反馈
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 [BAHome](https://github.com/BAHome) 团队，我们必定会认真对待每一个问题！ <br>

> 2、以后提需求和 bug 的同学，记得把 git 或者博客链接给我们，我直接超链到你们那里！希望大家积极参与测试！<br> 

## 7、BAHome 团队成员
> 1、QQ 群 
479663605 <br> 
【注意：此群为 2 元 付费群，介意的小伙伴儿勿扰！】<br> 

> 孙博岩 <br> 
QQ：137361770 <br> 
git：[https://github.com/boai](https://github.com/boai) <br>
简书：[http://www.jianshu.com/u/95c9800fdf47](http://www.jianshu.com/u/95c9800fdf47) <br>
微博：[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123) <br>

> 马景丽 <br> 
QQ：1253540493 <br> 
git：[https://github.com/MaJingli](https://github.com/MaJingli) <br>

> 陆晓峰 <br> 
QQ：442171865 <br> 
git：[https://github.com/zeR0Lu](https://github.com/zeR0Lu) <br>

> 陈集 <br> 
QQ：3161182978 <br> 
git：[https://github.com/chenjipdc](https://github.com/chenjipdc) <br>
简书：[http://www.jianshu.com/u/90ae559fc21d](http://www.jianshu.com/u/90ae559fc21d)

> 任子丰 <br> 
QQ：459643690 <br> 
git：[https://github.com/renzifeng](https://github.com/renzifeng) <br>

> 吴丰收 <br> 
QQ：498121294 <br> 

> 石少庸 <br> 
QQ：363605775 <br> 
git：[https://github.com/CrazyCoderShi](https://github.com/CrazyCoderShi) <br>
简书：[http://www.jianshu.com/u/0726f4d689a3](http://www.jianshu.com/u/0726f4d689a3)

## 8、开发环境 和 支持版本
> 开发使用 最新版本 Xcode，理论上支持 iOS 9 及以上版本，如有版本适配问题，请及时反馈！多谢合作！

## 9、感谢
> 感谢 [BAHome](https://github.com/BAHome) 团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

>  [BAHome](https://github.com/BAHome) 的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

