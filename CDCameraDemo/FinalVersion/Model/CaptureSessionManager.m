//
//  CaptureSessionManager.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "CaptureSessionManager.h"
#import <ImageIO/ImageIO.h>

@implementation CaptureSessionManager

#pragma mark -- Capture Session 配置 --
- (instancetype)init{
    if ((self = [super init])){
        _captureSession = [[AVCaptureSession alloc] init];
        _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    return self;
}

- (void)addVideoPreviewLayer{
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

- (void)initiateCaptureSessionForCamera:(CameraType)cameraType{
    // 遍历设备和每个参数指定->活跃相机
    for (AVCaptureDevice *device in AVCaptureDevice.devices)
    {
        if ([device hasMediaType:AVMediaTypeVideo])
        {
            switch (cameraType) {
                case RearFacingCamera:
                    if ([device position] == AVCaptureDevicePositionBack){
                        _activeCamera = device;
                    }
                    break;
                case FrontFacingCamera:
                    if ([device position] == AVCaptureDevicePositionFront){
                        _activeCamera = device;
                    }
                    break;
            }
        }
    }
    
    NSError *error = nil;
    BOOL deviceAvailability = YES;
    AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_activeCamera error:&error];
    if (!error && [_captureSession canAddInput:cameraDeviceInput]) {
        [_captureSession addInput:cameraDeviceInput];
    }else{
        deviceAvailability = NO;
    }
    
    if (self.delegate) {
        [self.delegate cameraSessionManagerDidReportAvailability:deviceAvailability forCameraType:cameraType];
    }
}

- (void)initiateStatisticsReportWithInterval:(CGFloat)interval{
    
    __block id blockSafeSelf = self;
    
    [[NSOperationQueue new] addOperationWithBlock:^{
        do {
            [NSThread sleepForTimeInterval:interval];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (self.delegate){
                    [self.delegate cameraSessionManagerDidReportDeviceStatistics:cameraStatisticsMake(_activeCamera.lensAperture, CMTimeGetSeconds(_activeCamera.exposureDuration), _activeCamera.ISO, _activeCamera.lensPosition)];
                }
            }];
        } while (blockSafeSelf);
    }];
}

- (void)addStillImageOutput{
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    [self getOrientationAdaptedCaptureConnection];
    
    [_captureSession addOutput:_stillImageOutput];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
    {
        [device lockForConfiguration:nil];
        [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [device unlockForConfiguration];
    }
}

- (void)captureStillImage{
    AVCaptureConnection *videoConnection = [self getOrientationAdaptedCaptureConnection];
    if (videoConnection) {
        [_stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
         ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
             if (exifAttachments) {
                 //Attachements Found
             } else {
                 //No Attachments
             }
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
             UIImage *image = [[UIImage alloc] initWithData:imageData];
             _stillImage = image;
             _stillImageData = imageData;
             
             if (self.delegate)
                 [self.delegate cameraSessionManagerDidCaptureImage];
         }];
    }
    
    //如果闪光灯打开则关闭
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasFlash])
    {
        [device lockForConfiguration:nil];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device unlockForConfiguration];
    }
}

/*
- (void)setEnableTorch:(BOOL)enableTorch{
    _enableTorch = enableTorch;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash])
    {
        [device lockForConfiguration:nil];
        if (enableTorch) {
            [device setFlashMode:AVCaptureFlashModeOn];
            NSLog(@"闪光灯打开");
        }else {
            [device setFlashMode:AVCaptureFlashModeOff];
            NSLog(@"闪光灯关闭");
        }
        
        [device unlockForConfiguration];
    }
}
 */

// 闪光灯设置方法
- (void)setCameraFlashModel:(FlashCurrentState)flashCurrentState{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash])
    {
        [device lockForConfiguration:nil];
        switch (flashCurrentState) {
            case FlashCurrentStateOn:
                [device setFlashMode:AVCaptureFlashModeOn];
                NSLog(@"闪光灯打开");
                break;
            case FlashCurrentStateOff:
                [device setFlashMode:AVCaptureFlashModeOff];
                NSLog(@"闪光灯关闭");
                break;
            case FlashCurrentStateAuto:
                [device setFlashMode:AVCaptureFlashModeAuto];
                NSLog(@"闪光灯自动");
                break;
            default:
                break;
        }
        
        [device unlockForConfiguration];
    }
}

#pragma mark -- 共有方法 --

- (void)assignVideoOrienationForVideoConnection:(AVCaptureConnection *)videoConnection{
    AVCaptureVideoOrientation newOrientation;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
            newOrientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            newOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            newOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            newOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            newOrientation = AVCaptureVideoOrientationPortrait;
    }
    [videoConnection setVideoOrientation: newOrientation];
}


- (AVCaptureConnection *)getOrientationAdaptedCaptureConnection
{
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in [_stillImageOutput connections]){
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                [self assignVideoOrienationForVideoConnection:videoConnection];
                break;
            }
        }
        if (videoConnection) {
            [self assignVideoOrienationForVideoConnection:videoConnection];
            break;
        }
    }
    
    return videoConnection;
}

#pragma mark -- 销毁方法 --

// 停止相机，否则它会导致内存溢出
- (void)stop
{
    [_captureSession stopRunning];
    
    if(_captureSession.inputs.count > 0) {
        AVCaptureInput* input = [_captureSession.inputs objectAtIndex:0];
        [_captureSession removeInput:input];
    }
    if(_captureSession.outputs.count > 0) {
        AVCaptureVideoDataOutput* output = [_captureSession.outputs objectAtIndex:0];
        [_captureSession removeOutput:output];
    }
}

- (void)dealloc{
    [self stop];
}

@end
