//
//  BANetManager_Version.h
//  BANetManager
//
//  Created by boai on 2017/11/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BANetManager_Version_h
#define BANetManager_Version_h

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BANetManager
 
 最新更新时间：2018-05-22 【倒叙】<br>
 最新Version：【Version：2.3.10】<br>
 更新内容：<br>
 2.3.10.1、新增 属性【isOpenLog】（注意：是否开启 log 打印，默认不开启）
 2.3.10.2、优化部分代码
 
 最新更新时间：2018-04-16 【倒叙】<br>
 最新Version：【Version：2.3.9】<br>
 更新内容：<br>
 2.3.9.1、新增 isSetQueryStringSerialization 配置参数，可以将传入 的 string 参数序列化，使用方式：BANetManagerShare.isSetQueryStringSerialization = YES，详见【BANetManager.h】文件;
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
 
 最新更新时间：2017-07-17 【倒叙】<br>
 最新Version：【Version：2.3.3】<br>
 更新内容：<br>
 2.3.3.1、新增 清除 请求头<br>
 2.3.3.2、新增 文件上传<br>
 2.3.3.3、优化多图上传<br>
 
 最新更新时间：2017-05-03 【倒叙】<br>
 最新Version：【Version：2.2】<br>
 更新内容：<br>
 2.2.1、优化方法名命名规范
 2.2.2、优化网络状态实时监测 block 回调，去除多余设置，需要网络判断，直接调用block回调即可
 2.2.3、新增 YYCache 缓存处理
 2.2.4、新增自定义：超时设置
 2.2.5、新增自定义：requestSerializer设置
 2.2.6、新增自定义：responseSerializer设置
 2.2.7、新增自定义：请求头设置
 2.2.8、新增自定义 CA 证书 和 HTTPS 请求配置，只需把证书导入项目目录即可，无需设置
 2.2.9、新增史上最全的 AFN 请求 NSLog 打印，详见 demo 控制台打印结果
 2.2.10、新增 DEBUG 模式下的 NSLog 判断，release 下不会打印，请放心使用
 2.2.11、如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
 2.2.12、由于新版本改动较大，原有方法命名可能有所改动，希望老用户见谅！
 2.2.13、目前版本较稳定，稍后奉上 pod 版本！请大家耐心等待
 
 最新更新时间：2016-11-24 【倒叙】
 最新Version：【Version：2.1】
 更新内容：
 2.1.1、优化方法名命名规范
 2.1.2、新增网络状态实时监测 block 回调，新增单独网络监测 bool 返回，详见 demo
 2.1.3、新增旧方法更新提示
 2.1.4、优化各种注释
 
 最新更新时间：2016-11-17
 最新Version：【Version：2.0】
 更新内容：
 2.0.1、优化方法名命名规范
 2.0.2、新增部分注释
 2.0.3、视频上传方法对接，目前有很多项目对接成功
 
 */


#endif /* BANetManager_Version_h */
