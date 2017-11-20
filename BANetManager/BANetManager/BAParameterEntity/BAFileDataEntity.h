//
//  BAFileDataEntity.h
//  BANetManager
//
//  Created by DK on 2017/11/17.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BADataEntity.h"

@interface BAFileDataEntity : BADataEntity

/** 文件名字 */
@property (nonatomic, copy) NSString *fileName;

/** 1、如果是上传操作，为上传文件的本地沙河路径
    2、如果是下载操作，为下载文件保存路径
 */
@property (nonatomic, copy) NSString *filePath;

@end
