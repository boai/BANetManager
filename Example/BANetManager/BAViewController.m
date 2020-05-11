
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


#import "BAViewController.h"
#import "BANetManager_OC.h"

#import "MJExtension.h"

static NSString * const url1 = @"http://c.m.163.com/nc/video/home/1-10.html";
static NSString * const url2 = @"http://apis.baidu.com/apistore/";
static NSString * const url3 = @"http://yycloudvod1932283664.bs2dl.yy.com/djMxYTkzNjQzNzNkNmU4ODc1NzY1ODQ3ZmU5ZDJlODkxMTIwMjM2NTE5Nw";
static NSString * const url4 = @"http://www.aomy.com/attach/2012-09/1347583576vgC6.jpg";
static NSString * const url5 = @"http://chanyouji.com/api/users/likes/268717.json";

static NSString * const url6 = @"http://li.itingwang.com:9007/service/userlogin";

static NSString * const url7_https = @"https://api.jingjiribao.cn/v300/push/pushList";

#define defaultUrl        @"http://zl160528.15.baidusx.com/app/log_mobile.php"

/*！国内天气预报融合版－apikey */
//#define apikey  @"82428a4618b6aa313be6914d727cb9b7"

#define BAKit_ShowAlertWithMsg(msg) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

@interface BAViewController () {
    BOOL isFinishDownload;
}
@property (weak, nonatomic) IBOutlet UILabel *uploadLabel;

@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

- (IBAction)getData:(UIButton *)sender;

- (IBAction)postData:(UIButton *)sender;

- (IBAction)downloadData:(UIButton *)sender;

- (IBAction)uploadImageData:(UIButton *)sender;

- (IBAction)uploadVideoData:(UIButton *)sender;

- (IBAction)putData:(UIButton *)sender;

- (IBAction)deleteData:(UIButton *)sender;

- (IBAction)uploadFileButtonAction:(UIButton *)sender;

@property (nonatomic, strong) BAURLSessionTask  *tasks;


@end

@implementation BAViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"BANetManager";
    
    /*! 网络状态实时监测可以使用 block 回调，也可以使用单独方法判断 */
    [self ba_netType];
    
    // 清楚所有缓存，可以自由定义删除时间
    [BANetManagerShare ba_clearAllHttpCache];
}

#pragma mark - 网络类型判断
- (void)ba_netType {
//    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 0: {
                msg = @"未知网络";
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
            case 1: {
                msg = @"没有网络";
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
            case 2: {
                msg = @"您的网络类型为：手机 3G/4G 网络";
                BAKit_ShowAlertWithMsg(msg);
            }
                break;
            case 3: {
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
- (IBAction)getData:(UIButton *)sender {
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = url5;
    entity.needCache = YES;
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
//        NSLog(@"get 请求数据结果： *** %@", response);
        NSString *msg = [NSString stringWithFormat:@"get 请求数据结果：%@", response];
        BAKit_ShowAlertWithMsg(msg);
    } failureBlock:^(NSError *error) {
        
    } progressBlock:nil];
}

#pragma mark - post
- (IBAction)postData:(UIButton *)sender {
    [sender setTitle:@"post" forState:UIControlStateNormal];
    // 自定义超时设置
    BANetManagerShare.timeoutInterval = 15;
    
    // 自定义添加请求头
    NSDictionary *headerDict = @{@"Accept":@"application/json", @"Accept-Encoding":@"gzip", @"charset":@"utf-8"};
    BANetManagerShare.httpHeaderFieldDictionary = headerDict;
    
    // 自定义更改 requestSerializer
//        BANetManagerShare.requestSerializer = BAHttpRequestSerializerHTTP;
    // 自定义更改 responseSerializer
//        BANetManagerShare.responseSerializer = BAHttpRequestSerializerHTTP;
    
    // 清楚当前所有请求头
//    [BANetManager ba_clearAuthorizationHeader];
    
    NSString *url = @"http://apptest.bawanli.com/topup/index";
    
//    NSString *url = @"http://115.29.201.135/mobile/mobileapi.php";
//    NSString *parameters = @"sAp3OxNlYMZZa7OlRi2TwguoTtwNwwFwOo5k8LL3ERtcTbAvGPhZ5yUWiiIJeXx2WjYlnMU1nFOoi2JSKJDINW62lcM9DB9XDdZQACnY60g=";
//    int page = 1;
    NSDictionary *parameters = @{
                           @"sign":@"CDFBAD6F44CBD0F26771DCAEE522C2E8",
                           @"shop_code":@"lw"
                           };
   
//    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(page).stringValue, @"page", @"10", @"per_page", nil];;
    
    BADataEntity *entity = BADataEntity.new;
    entity.urlString = url;
    entity.needCache = NO;
    // AFN 4.0 可以单独适配 header 了
//    entity.headers = @{};
    entity.parameters = [parameters mj_JSONString];
    // 此请求为 body 请求, 非 body 请求注掉下面那行就行或者设置为 NO
    entity.isSetQueryStringSerialization = YES;

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
- (IBAction)downloadData:(UIButton *)sender {
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
        self->isFinishDownload = YES;
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
- (IBAction)uploadImageData:(UIButton *)sender {
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
- (IBAction)uploadVideoData:(UIButton *)sender {
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
- (IBAction)putData:(UIButton *)sender {
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
- (IBAction)deleteData:(UIButton *)sender {
    BADataEntity *entity = [BADataEntity new];
    [BANetManager ba_request_DELETEWithEntity:entity successBlock:nil failureBlock:nil progressBlock:nil];
}

#pragma mark - 上传文件
- (IBAction)uploadFileButtonAction:(UIButton *)sender {
    BAFileDataEntity *fileEntity = [BAFileDataEntity new];
    [BANetManager ba_uploadFileWithWithEntity:fileEntity successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
