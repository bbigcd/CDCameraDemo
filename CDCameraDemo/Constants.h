//
//  Constants.h
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/8.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

typedef NS_ENUM(BOOL, CameraType) {
    FrontFacingCamera,
    RearFacingCamera,
};

typedef struct {
    CGFloat ISO;
    CGFloat exposureDuration;
    CGFloat aperture;
    CGFloat lensPosition;
} CameraStatistics;

CameraStatistics cameraStatisticsMake(float aperture, float exposureDuration, float ISO, float lensPostion);

@end
