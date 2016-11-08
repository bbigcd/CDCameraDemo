//
//  Constants.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/8.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "Constants.h"

@implementation Constants

CameraStatistics cameraStatisticsMake(float aperture, float exposureDuration, float ISO, float lensPostion){
    CameraStatistics cameraStatistics;
    cameraStatistics.aperture = aperture;
    cameraStatistics.exposureDuration = exposureDuration;
    cameraStatistics.ISO = ISO;
    cameraStatistics.lensPosition = lensPostion;
    return cameraStatistics;
}

@end
