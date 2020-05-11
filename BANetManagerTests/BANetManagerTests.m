//
//  BANetManagerTests.m
//  BANetManagerTests
//
//  Created by 博爱 on 2018/5/9.
//  Copyright © 2018年 boai. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BANetManager_OC.h"

static NSString * const url1 = @"http://c.m.163.com/nc/video/home/1-10.html";

@interface BANetManagerTests : XCTestCase

@end

@implementation BANetManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
//    BANetManager *netManger = [];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - 网络类型判断
- (void)testBa_netType {
    //    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 0: {
                msg = @"未知网络";
                NSLog(msg);
            }
                break;
            case 1: {
                msg = @"没有网络";
                NSLog(msg);
            }
                break;
            case 2: {
                msg = @"您的网络类型为：手机 3G/4G 网络";
                NSLog(msg);
            }
                break;
            case 3: {
                msg = @"您的网络类型为：wifi 网络";
                /*! wifi 网络下请求网络：可以在父类写此方法，具体使用demo，详见：https://github.com/boai/BABaseProject */
                NSLog(msg);
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)testGet {
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = url1;
    entity.needCache = YES;
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSLog(@"get 请求数据结果： *** %@", response);
        NSString *msg = [NSString stringWithFormat:@"get 请求数据结果：%@", response];
        NSLog(msg);
    } failureBlock:^(NSError *error) {
        
    } progressBlock:nil];
}












@end
