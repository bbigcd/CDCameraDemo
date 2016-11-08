//
//  CDCaptureSessionManager.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/8.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "CDCaptureSessionManager.h"
#import <ImageIO/ImageIO.h>

@implementation CDCaptureSessionManager

// 初始化
- (instancetype)init{
    if ((self = [super init])) {
        _captureSession = [[AVCaptureSession alloc] init];
        _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    return self;
}

// 预览layer
- (void)addVideoPreviewLayer{
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

// 启动session
- (void)initiateCaptureSessionForCamera:(CameraType)cameraType{
    // 前、后摄像头切换
    for (AVCaptureDevice *device in AVCaptureDevice.devices) {
        if ([device hasMediaType:AVMediaTypeVideo]){
            switch (cameraType) {
                case FrontFacingCamera: {
                    if (device.position == AVCaptureDevicePositionBack) {
                        _activeCamera = device;
                    }
                    break;
                }
                case RearFacingCamera: {
                    if (device.position == AVCaptureDevicePositionFront) {
                        _activeCamera = device;
                    }
                    break;
                }
            }
        }
    }
    NSError *error = nil;
    BOOL deviceAvailability = YES;
    
    AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_activeCamera error:&error];
    
    if (!error && [self.captureSession canAddInput:cameraDeviceInput]) {
        [self.captureSession addInput:cameraDeviceInput];
    }
    
    if (self.delegate) {
        [self.delegate cameraSessionManagerDidReportAvailability:deviceAvailability forCameraType:cameraType];
    }
}

- (void)initiateStatisticsReportWithInterval:(CGFloat)interval {
    __block id blockSafeSelf = self;
    [[NSOperationQueue new] addOperationWithBlock:^{
        do {
            [NSThread sleepForTimeInterval:interval];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (self.delegate)
                {
                    [self.delegate cameraSessionManagerDidReportDeviceStatistics:cameraStatisticsMake(_activeCamera.lensAperture, CMTimeGetSeconds(_activeCamera.exposureDuration), _activeCamera.ISO, _activeCamera.lensPosition)];
                }
            }];
        } while (blockSafeSelf);
    }];
}

- (void)addStillImageOutput
{
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    [self getOrientationAdaptedCaptureConnection];
    
    [_captureSession addOutput:[self stillImageOutput]];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
    {
        [device lockForConfiguration:nil];
        [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [device unlockForConfiguration];
    }
}


- (void)captureStillImage
{
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
             self.stillImage = image;
             self.stillImageData = imageData;
             
             if (self.delegate)
                 [self.delegate cameraSessionManagerDidCaptureImage];
         }];
    }
    
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

- (void)setEnableTorch:(BOOL)enableTorch
{
    _enableTorch = enableTorch;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash])
    {
        [device lockForConfiguration:nil];
        if (enableTorch) { [device setTorchMode:AVCaptureTorchModeOn]; }
        else { [device setTorchMode:AVCaptureTorchModeOff]; }
        [device unlockForConfiguration];
    }
}

#pragma mark - Helper Method(s)

- (void)assignVideoOrienationForVideoConnection:(AVCaptureConnection *)videoConnection
{
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
    
    for (AVCaptureConnection *connection in [_stillImageOutput connections]) {
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


#pragma mark - Cleanup Functions
// 销毁
- (void)stop
{
    [self.captureSession stopRunning];
    
    if(self.captureSession.inputs.count > 0) {
        AVCaptureInput* input = [self.captureSession.inputs objectAtIndex:0];
        [self.captureSession removeInput:input];
    }
    if(self.captureSession.outputs.count > 0) {
        AVCaptureVideoDataOutput* output = [self.captureSession.outputs objectAtIndex:0];
        [self.captureSession removeOutput:output];
    }
    
}

- (void)dealloc {
    [self stop];
}


@end
