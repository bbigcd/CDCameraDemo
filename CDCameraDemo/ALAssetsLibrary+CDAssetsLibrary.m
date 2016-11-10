//
//  ALAssetsLibrary+CDAssetsLibrary.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/10.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "ALAssetsLibrary+CDAssetsLibrary.h"


@implementation ALAssetsLibrary (CDAssetsLibrary)

- (void)latestAsset:(void (^)(ALAsset * _Nullable, NSError *_Nullable))block {
    [self enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            /* NSEnumerationReverse 遍历方式*/
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    if (block) {
                        block(result,nil);
                    }
                    *stop = YES;
                }
            }];
            *stop = YES;
        }
    } failureBlock:^(NSError *error) {
        if (error) {
            if (block) {
                block(nil,error);
            }
        }
    }];
}

@end
