
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


#import "ViewController.h"
#import "BANetManager.h"

static NSString * const url1 = @"http://c.m.163.com/nc/video/home/1-10.html";
static NSString * const url2 = @"http://apis.baidu.com/apistore/";
static NSString * const url3 = @"http://yycloudvod1932283664.bs2dl.yy.com/djMxYTkzNjQzNzNkNmU4ODc1NzY1ODQ3ZmU5ZDJlODkxMTIwMjM2NTE5Nw";
static NSString * const url4 = @"http://www.aomy.com/attach/2012-09/1347583576vgC6.jpg";

/*！国内天气预报融合版－apikey */
//#define apikey  @"82428a4618b6aa313be6914d727cb9b7"

@interface ViewController ()
{
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


@property (nonatomic, strong) BAURLSessionTask  *tasks;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"AFNetworking 3.1 封装demo";
    
    /*! 网络状态实时监测可以使用 block 回调，也可以使用单独方法判断 */
    [self ba_netType];
    
}

#pragma mark - 一次性网络状态判断
- (void)ba_getCurrentNetworkStatusUseDefine:(BOOL)useDefine
{
    if (useDefine)
    {
        if (kIsHaveNetwork)
        {
            NSLog(@"有网络");
            if (kIs3GOr4GNetwork)
            {
                NSLog(@"手机网络");
            }
            else if (kIsWiFiNetwork)
            {
                NSLog(@"WiFi网络");
            }
        }
    }
    else
    {
        /*! 也可以使用单独方法判断 */
        if ([BANetManager ba_isHaveNetwork])
        {
            NSLog(@"当前有网络");
            if ([BANetManager ba_isWiFiNetwork])
            {
                NSLog(@"当前有 wifi 网络");
            }
            if ([BANetManager ba_is3GOr4GNetwork])
            {
                NSLog(@"当前有 3GOr4G 网络");
            }
        }
    }
}

#pragma mark - 网络类型判断
- (void)ba_netType
{
    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
//        NSString *netType;
//        switch (status) {
//            case 0:
//                netType = @"未知网络";
//                [weakSelf alertWithMsg:netType];
//                break;
//            case 1:
//                netType = @"没有网络";
//                [weakSelf alertWithMsg:netType];
//                break;
//            case 2:
//                netType = @"您的网络类型为：手机 3G/4G 网络";
//                [weakSelf alertWithMsg:netType];
//                break;
//            case 3:
//                netType = @"您的网络类型为：wifi 网络";
//                /*! wifi 网络下请求网络：可以在父类写此方法，具体使用demo，详见：https://github.com/boai/BABaseProject */
//                [weakSelf getData:nil];
//                break;
//                
//            default:
//                break;
//        }
        [weakSelf ba_getCurrentNetworkStatusUseDefine:YES];
       
    }];
}

- (void)alertWithMsg:(NSString *)msg
{
    [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:msg delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil] show];
}

#pragma mark - ***** get
- (IBAction)getData:(UIButton *)sender
{
    BAWeak;
    [BANetManager ba_requestWithType:BAHttpRequestTypeGet
                           urlString:url1
                          parameters:nil
                        successBlock:^(id response) {
        
        /*! 新增get请求缓存，飞行模式下开启试试看！ */
        NSLog(@"get请求数据成功： *** %@", response);
        [weakSelf alertWithMsg:@"get请求成功！"];

    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** post
- (IBAction)postData:(UIButton *)sender
{
    BAWeak;
    /*! 此处的手机号填写自己的手机号，返回成功，即可收到短信验证码 */
    NSString *url = @"http://api.mncnet.cn/mncApp/common/sendSmsCode";
    NSDictionary *params = @{@"apiKey":@"A71F631C4788AB35AB1EE0191BD7FBDE",
                             @"mobile":@" ",
                             @"sendType":@"1"
                             };

    [BANetManager ba_requestWithType:BAHttpRequestTypePost
                           urlString:url
                          parameters:params
                        successBlock:^(id response) {
        
        NSLog(@"post请求数据成功： *** %@", response);
        [weakSelf alertWithMsg:@"post请求成功！"];
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** 下载视频、图片
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
    BAWeak;
    self.tasks = [BANetManager ba_downLoadFileWithUrlString:url3
                                                 parameters:nil
                                                   savaPath:path1
                                               successBlock:^(id response) {

        NSLog(@"下载完成，路径为：%@", response);
        self.downloadLabel.text = @"下载完成";
        isFinishDownload = YES;
        [downloadBtn setTitle:@"下载完成" forState:UIControlStateNormal];
        [downloadBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       [weakSelf alertWithMsg:@"视频下载完成！"];
        
    } failureBlock:^(NSError *error) {
        
    } downLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        /*! 封装方法里已经回到主线程，所有这里不用再调主线程了 */
        self.downloadLabel.text = [NSString stringWithFormat:@"下载进度：%.2lld%%",100 * bytesProgress/totalBytesProgress];
        [downloadBtn setTitle:@"下载中..." forState:UIControlStateNormal];
    }];
    
//    sender.selected = !sender.selected;
//    if (sender.selected)
//    {
//        [self.tasks resume];
//    }
//    else
//    {
//        [self.tasks suspend];
//        UIButton *downloadBtn = (UIButton *)sender;
//        [downloadBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
//    }
    
}

#pragma mark - ***** 上传图片
- (IBAction)uploadImageData:(UIButton *)sender
{
    /*! 
     
     1、此上传图片单张、多图上传都经过几十个项目亲测可用，大家可以放心使用，使用过程中有问题，请加群：479663605 进行反馈，多谢！
     2、此处只需要传URL 和 parameters，和你的image数组、FileName就行了，具体压缩方法都已经做好处理！
     
     
     3、注意：如果使用PHP后台，后台不会对接此接口的话，博爱已经为你们量身定做了PHP后台接口，你们只需要把文件夹中的 postdynamic.php 文件发送给你们的PHP后台同事，他们就知道了，里面都有详细说明！
     
     */

    [BANetManager ba_uploadImageWithUrlString:nil parameters:nil imageArray:nil fileName:nil successBlock:^(id response) {
        
    } failurBlock:^(NSError *error) {
        
    } upLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** 上传视频
- (IBAction)uploadVideoData:(UIButton *)sender
{
    /*!
     
     1、此上传视频都经过几十个项目亲测可用，大家可以放心使用，使用过程中有问题，请加群：479663605 进行反馈，多谢！
     2、此处只需要传URL 和 parameters就行了，具体压缩方法都已经做好处理！

     */
    [BANetManager ba_uploadVideoWithUrlString:nil parameters:nil videoPath:nil successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (IBAction)putData:(UIButton *)sender
{
    [BANetManager ba_requestWithType:BAHttpRequestTypePut urlString:nil parameters:nil successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (IBAction)deleteData:(UIButton *)sender
{
    [BANetManager ba_requestWithType:BAHttpRequestTypeDelete urlString:nil parameters:nil successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
