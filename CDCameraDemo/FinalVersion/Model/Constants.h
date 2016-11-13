//
//  Constants.h
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

// 前后摄像头
typedef NS_ENUM(BOOL, CameraType){
    FrontFacingCamera,
    RearFacingCamera,
};

typedef NS_ENUM(NSInteger, FlashCurrentState){
    FlashCurrentStateOn,
    FlashCurrentStateOff,
    FlashCurrentStateAuto,
};

// 结构体
typedef struct {
    CGFloat ISO;
    CGFloat exposureDuration;
    CGFloat aperture;
    CGFloat lensPosition;
} CameraStatistics;


/**
 *  函数原型声明
 *
 *  @param aperture         孔径
 *  @param exposureDuration 曝光时间
 *  @param ISO              感光度
 *  @param lensPostion      镜头位置
 *
 *  @return 相机数据设置
 */
CameraStatistics cameraStatisticsMake(float aperture, float exposureDuration, float ISO, float lensPostion);


@end
