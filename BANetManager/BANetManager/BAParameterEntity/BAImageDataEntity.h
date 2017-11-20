//
//  BAImageDataEntity.h
//  BANetManager
//
//  Created by DK on 2017/11/17.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BADataEntity.h"
#import <CoreGraphics/CoreGraphics.h>

@interface BAImageDataEntity : BADataEntity

/** 上传的图片数组 */
@property (nonatomic, copy) NSArray *imageArray;
/** 图片名称 */
@property (nonatomic, copy) NSArray<NSString *> *fileNames;
/** 图片类型 png、jpg、gif */
@property (nonatomic, copy) NSString *imageType;
/** 图片压缩比率（0~1.0）*/
@property (nonatomic, assign) CGFloat imageScale;

@end
