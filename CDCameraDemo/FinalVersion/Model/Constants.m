//
//  Constants.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "Constants.h"

@implementation Constants

CameraStatistics cameraStatisticsMake(float aperture, float exposureDuration, float ISO, float lensPostion) {
    CameraStatistics cameraStatistics;
    cameraStatistics.aperture = aperture;
    cameraStatistics.exposureDuration = exposureDuration;
    cameraStatistics.ISO = ISO;
    cameraStatistics.lensPosition = lensPostion;
    return cameraStatistics;
}


@end
