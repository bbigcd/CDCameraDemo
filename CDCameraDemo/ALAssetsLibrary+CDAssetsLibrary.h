//
//  ALAssetsLibrary+CDAssetsLibrary.h
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/10.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetsLibrary (CDAssetsLibrary)

/**
 *  获取最新一张图片
 *
 *  @param block 回调
 */
- (void)latestAsset:(void(^_Nullable)(ALAsset * _Nullable asset,NSError *_Nullable error))block;

@end
