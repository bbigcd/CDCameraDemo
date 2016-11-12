//
//  CaptureSessionManager.h
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "Constants.h"

#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"

// 代理定义
@protocol CaptureSessionManagerDelegate <NSObject>

@required
- (void)cameraSessionManagerDidCaptureImage;
- (void)cameraSessionManagerFailedToCaptureImage;
- (void)cameraSessionManagerDidReportAvailability:(BOOL)deviceAvailability forCameraType:(CameraType)cameraType;
- (void)cameraSessionManagerDidReportDeviceStatistics:(CameraStatistics)deviceStatistics; //每0.125秒报告一次

@end

@interface CaptureSessionManager : NSObject

@property (nonatomic, weak) id<CaptureSessionManagerDelegate>delegate;
@property (nonatomic, weak) AVCaptureDevice *activeCamera;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) UIImage *stillImage;
@property (nonatomic, strong) NSData *stillImageData;

@property (nonatomic, assign, getter=isTorchEnabled) BOOL enableTorch;

- (void)addStillImageOutput;
- (void)captureStillImage;
- (void)addVideoPreviewLayer;
- (void)setCameraFlashModel:(FlashCurrentState)flashCurrentState;
- (void)initiateCaptureSessionForCamera:(CameraType)cameraType;
- (void)stop;

@end
