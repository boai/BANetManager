//
//  AppDelegate.m
//  BANetManagerDemo
//
//  Created by 博爱 on 16/6/3.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "AppDelegate.h"
#import "BANetManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*! 设置默认缓存大小 */
    [self ba_setNSURLCache];

    return YES;
}

#pragma mark - ***** 设置默认缓存大小
- (void)ba_setNSURLCache
{
    /*!
     
     首先要知道，POST请求不能被缓存，只有 GET 请求能被缓存。因为从数学的角度来讲，GET 的结果是 幂等 的，就好像字典里的 key 与 value 就是幂等的，而 POST 不 幂等 。缓存的思路就是将查询的参数组成的值作为 key ，对应结果作为value。从这个意义上说，一个文件的资源链接，也叫 GET 请求，下文也会这样看待。
     80%的缓存需求：两行代码就可满足
     设置缓存只需要三个步骤：
     
     第一个步骤：请使用 GET 请求。
     
     第二个步骤：
     
     如果你已经使用 了 GET 请求，iOS 系统 SDK 已经帮你做好了缓存。你需要的仅仅是设置下内存缓存大小、磁盘缓存大小、以及缓存路径。甚至这两行代码不设置也是可以的，会有一个默认值。代码如下：
     
     要注意
     
     iOS 5.0开始，支持磁盘缓存，但仅支持 HTTP
     iOS 6.0开始，支持 HTTPS 缓存
     
     */
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
