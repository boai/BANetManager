
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



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *uploadLabel;

@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

- (IBAction)getData:(UIButton *)sender;

- (IBAction)postData:(UIButton *)sender;

- (IBAction)downloadData:(UIButton *)sender;

- (IBAction)uploadImageData:(UIButton *)sender;

- (IBAction)uploadVideoData:(UIButton *)sender;

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
        
        NSLog(@"get请求数据成功： *** %@", response);
        
    } withFailureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** post
- (IBAction)postData:(UIButton *)sender
{
    self.tasks = [BANetManager ba_requestWithType:BAHttpRequestTypePost withUrlString:[NSString stringWithFormat:@"%@%@", url2, @"idservice/id"] withParameters:@{@"id":@"420984198704207895"} withSuccessBlock:^(id response) {
        
        NSLog(@"post请求数据成功： *** %@", response);
        
    } withFailureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** 下载视频、图片
- (IBAction)downloadData:(UIButton *)sender
{
    NSString *path1 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/半塘.mp4"]];
//    NSString *path2 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/image123.mp3"]];
    
    self.tasks = [BANetManager ba_downLoadFileWithOperations:nil withSavaPath:path1 withUrlString:url4 withSuccessBlock:^(id response) {
        
        NSLog(@"下载完成，路径为：%@", response);
        self.downloadLabel.text = @"下载完成";

    } withFailureBlock:^(NSError *error) {
        
    } withDownLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        /*! 封装方法里已经回到主线程，所有这里不用再调主线程了 */
        self.downloadLabel.text = [NSString stringWithFormat:@"下载进度：%.2lld%%",100 * bytesProgress/totalBytesProgress];
    }];
}

#pragma mark - ***** 上传图片
- (IBAction)uploadImageData:(UIButton *)sender
{
    /*! 此处要你们自己测拉，我没有相关服务器，只好麻烦各位了，发现有问题了几十联系博爱哈！ */
    /*! 如果有大神补充完整也可以，将代码不全后发送给我，多谢！ */
    self.tasks = [BANetManager ba_uploadImageWithOperations:nil withImageArray:nil withtargetWidth:200 withUrlString:nil withSuccessBlock:^(id response) {
        
    } withFailurBlock:^(NSError *error) {
        
    } withUpLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - ***** 上传视频
- (IBAction)uploadVideoData:(UIButton *)sender
{
    /*! 此处要你们自己测拉，我没有相关服务器，只好麻烦各位了，发现有问题了几十联系博爱哈！ */
    /*! 如果有大神补充完整也可以，将代码不全后发送给我，多谢！ */
    [BANetManager ba_uploadVideoWithOperaitons:nil withVideoPath:nil withUrlString:nil withSuccessBlock:^(id response) {
        
    } withFailureBlock:^(NSError *error) {
        
    } withUploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
