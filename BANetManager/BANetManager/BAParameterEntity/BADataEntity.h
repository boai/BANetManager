//
//  DataEntity.h
//  BANetManager
//
//  Created by DK on 2017/11/17.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 请求实体，承载请求参数 */
@interface BADataEntity : NSObject

/** 请求路径 */
@property (nonatomic, copy) NSString *urlString;
/** 请求参数 */
@property (nonatomic, copy) id parameters;
/** 是否缓存响应 */
@property (nonatomic, assign, getter=isNeedCache) BOOL needCache;

@end
