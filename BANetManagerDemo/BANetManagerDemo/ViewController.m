
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
 * QQ     : 博爱1616【137361770】
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"AFNetworking 3.1 封装demo";
    [BANetManager ba_startNetWorkMonitoring];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ***** get
- (IBAction)getData:(UIButton *)sender
{
    self.tasks = [BANetManager ba_requestWithType:BAHttpRequestTypeGet withUrlString:url1 withParameters:nil withSuccessBlock:^(id response) {
        
        /*! 新增get请求缓存，飞行模式下开启试试看！ */
        NSLog(@"get请求数据成功： *** %@", response);
        [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"get请求成功！" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil] show];
        return;
    } withFailureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** post
- (IBAction)postData:(UIButton *)sender
{
    /*! 此处的手机号填写自己的手机号，返回成功，即可收到短信验证码 */
    NSString *url = @"http://api.mncnet.cn/mncApp/common/sendSmsCode";
    NSDictionary *params = @{@"apiKey":@"A71F631C4788AB35AB1EE0191BD7FBDE", @"mobile":@"", @"sendType":@"1"};

    self.tasks = [BANetManager ba_requestWithType:BAHttpRequestTypePost withUrlString:url withParameters:params withSuccessBlock:^(id response) {
        
        NSLog(@"post请求数据成功： *** %@", response);
        [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"post请求成功！" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil] show];
        return;
    } withFailureBlock:^(NSError *error) {
        
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
    
    self.tasks = [BANetManager ba_downLoadFileWithUrlString:url4 parameters:nil withSavaPath:path1 withSuccessBlock:^(id response) {

        NSLog(@"下载完成，路径为：%@", response);
        self.downloadLabel.text = @"下载完成";
        isFinishDownload = YES;
        [downloadBtn setTitle:@"下载完成" forState:UIControlStateNormal];
        [downloadBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"视频下载完成！" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil] show];
        return;
        
    } withFailureBlock:^(NSError *error) {
        
    } withDownLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
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
    /*! 此处要你们自己测拉，我没有相关服务器，只好麻烦各位了，发现有问题了及时联系博爱哈！ */
    /*! 如果有大神补充完整也可以，将代码不全后发送给我，多谢！ */
    
    /*! 此处只需要传URL 和 parameters，和你的image数组就行了，具体压缩方法都已经做好处理！ */
    self.tasks = [BANetManager ba_uploadImageWithUrlString:nil parameters:nil withImageArray:nil withSuccessBlock:^(id response) {
        
    } withFailurBlock:^(NSError *error) {
        
    } withUpLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** 上传视频
- (IBAction)uploadVideoData:(UIButton *)sender
{
    /*! 此处要你们自己测拉，我没有相关服务器，只好麻烦各位了，发现有问题了几十联系博爱哈！ */
    /*! 如果有大神补充完整也可以，将代码补全后发送给我，多谢！ */
    
    [BANetManager ba_uploadVideoWithUrlString:nil parameters:nil withVideoPath:nil withSuccessBlock:^(id response) {
        
    } withFailureBlock:^(NSError *error) {
        
    } withUploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (IBAction)putData:(UIButton *)sender
{
    /*! 此处要你们自己测拉，我没有相关服务器，只好麻烦各位了，发现有问题了几十联系博爱哈！ */
    /*! 如果有大神补充完整也可以，将代码补全后发送给我，多谢！ */
    [BANetManager ba_requestWithType:BAHttpRequestTypePut withUrlString:nil withParameters:nil withSuccessBlock:^(id response) {
        
    } withFailureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (IBAction)deleteData:(UIButton *)sender
{
    /*! 此处要你们自己测拉，我没有相关服务器，只好麻烦各位了，发现有问题了几十联系博爱哈！ */
    /*! 如果有大神补充完整也可以，将代码补全后发送给我，多谢！ */
    [BANetManager ba_requestWithType:BAHttpRequestTypeDelete withUrlString:nil withParameters:nil withSuccessBlock:^(id response) {
        
    } withFailureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
