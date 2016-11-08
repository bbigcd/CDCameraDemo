//
//  CDCaptureSessionManager.h
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/8.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"

@protocol CaptureSessionManagerDelegate <NSObject>

@required
- (void)cameraSessionManagerDidCaptureImage;
- (void)cameraSessionManagerFailedToCaptureImage;
- (void)cameraSessionManagerDidReportAvailability:(BOOL)deviceAvailability forCameraType:(CameraType)cameraType;
- (void)cameraSessionManagerDidReportDeviceStatistics:(CameraStatistics)deviceStatistics;

@end


@interface CDCaptureSessionManager : NSObject

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
- (void)initiateCaptureSessionForCamera:(CameraType)cameraType;
- (void)stop;

@end
