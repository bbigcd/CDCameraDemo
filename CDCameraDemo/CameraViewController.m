//
//  CameraViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/7.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "CameraViewController.h"
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(BOOL, CameraType) {
    FrontFacingCamera,
    RearFacingCamera,
};

@interface CameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureMovieFileOutput *movieOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAuthorization];
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    self.session = [AVCaptureSession new];
//    [_session beginConfiguration];
//    [self setupAVCapture];
    [_captureSession beginConfiguration];
    
    [self addVideo];
//    [self addAudio];
    [self addPreviewLayer];
    
    [_captureSession commitConfiguration];
    [_captureSession startRunning];
    
}

/*
- (void)setupAVCapture
{
    // Get the default camera device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device isTorchModeSupported:AVCaptureTorchModeOn]) {
        [device lockForConfiguration:nil];
        device.torchMode = AVCaptureTorchModeOn;//打开闪光灯
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        [device setActiveVideoMinFrameDuration:CMTimeMake(1, 30)];
    }
    
    // Create the AVCapture Session
    _session = [AVCaptureSession new];
    [_session beginConfiguration];
    
    // Create a AVCaptureDeviceInput with the camera device
    NSError *error = nil;
    NSString *title = [NSString stringWithFormat:@"Error %d", (int)[error code]];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        //[self teardownAVCapture];
        return;
    }
    
    if ([_session canAddInput:deviceInput])
        [_session addInput:deviceInput];
    
    // AVCaptureVideoDataOutput
    
    AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];
    NSDictionary *rgbOutputSettings = [NSDictionary dictionaryWithObject:
                                       [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [videoDataOutput setVideoSettings:rgbOutputSettings];
    [videoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
    
    if ([_session canAddOutput:videoDataOutput])
        [_session addOutput:videoDataOutput];
    AVCaptureConnection *connection = [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
//    [connection setVideoMinFrameDuration:CMTimeMake(1, 10)];
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    [_session commitConfiguration];
    [_session startRunning];
}
*/

- (void)addSession
{
    _captureSession = [[AVCaptureSession alloc] init];
    
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset640x480]) {
        [_captureSession setSessionPreset:AVCaptureSessionPreset640x480];
    }
}


- (void)addVideo
{
    
    // 获取摄像头输入设备， 创建 AVCaptureDeviceInput 对象
    _videoDevice = [self deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
    
    [self addVideoInput];
    [self addMovieOutput];
}

#pragma mark 获取摄像头-->前/后

- (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = devices.firstObject;
    
    for ( AVCaptureDevice *device in devices ) {
        if ( device.position == position ) {
            captureDevice = device;
            break;
        }
    }
    
    return captureDevice;
}

- (void)addVideoInput
{
    NSError *videoError;
    
    _videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:_videoDevice error:&videoError];
    if (videoError) {
        NSLog(@"---- 取得摄像头设备时出错 ------ %@",videoError);
        return;
    }
    
    if ([_captureSession canAddInput:_videoInput]) {
        [_captureSession addInput:_videoInput];
    }
}

- (void)addMovieOutput
{
    _movieOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    if ([_captureSession canAddOutput:_movieOutput]) {
        [_captureSession addOutput:_movieOutput];
        
        AVCaptureConnection *captureConnection = [_movieOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported]) {
            captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
        captureConnection.videoScaleAndCropFactor = captureConnection.videoMaxScaleAndCropFactor;
    }
    
}


- (void)addPreviewLayer
{
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    _captureVideoPreviewLayer.frame = self.view.layer.bounds;
    //    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _captureVideoPreviewLayer.connection.videoOrientation = [_movieOutput connectionWithMediaType:AVMediaTypeVideo].videoOrientation;
    _captureVideoPreviewLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    
    CALayer *layer = self.view.layer;
    layer.masksToBounds = true;
    [self.view layoutIfNeeded];
    [layer addSublayer:_captureVideoPreviewLayer];
    
}

/*
- (void)addAudio
{
    NSError *audioError;
    _audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    _audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:_audioDevice error:&audioError];
    if (audioError) {
        NSLog(@"取得录音设备时出错 ------ %@",audioError);
        return;
    }
    if ([_captureSession canAddInput:_audioInput]) {
        [_captureSession addInput:_audioInput];
    }
}
*/

//获取授权
- (void)getAuthorization
{
    
    //此处获取摄像头授权
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo])
    {
        case AVAuthorizationStatusAuthorized:       //已授权，可使用    The client is authorized to access the hardware supporting a media type.
        {
            break;
        }
        case AVAuthorizationStatusNotDetermined:    //未进行授权选择     Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
        {
            //则再次请求授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted){    //用户授权成功
                    return;
                } else {        //用户拒绝授权
                    return;
                }
            }];
            break;
        }
        default:                                    //用户拒绝授权/未授权
        {
            break;
        }
    }
    
}

/*
- (void)initiateCaptureSessionForCamera:(CameraType)cameraType {
    for (AVCaptureDevice *device in AVCaptureDevice.devices) if ([device hasMediaType:AVMediaTypeVideo]) {
        switch (cameraType) {
            case RearFacingCamera:  if ([device position] == AVCaptureDevicePositionBack)   _activeCamera = device; break;
            case FrontFacingCamera: if ([device position] == AVCaptureDevicePositionFront)  _activeCamera = device; break;
        }
    }
    
    NSError *error          = nil;
    BOOL deviceAvailability = YES;
    
    AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_activeCamera error:&error];
    if (!error && [self.session canAddInput:cameraDeviceInput]) [self.session addInput:cameraDeviceInput];
    else deviceAvailability = NO;
    
    //Report camera device availability
//    if (self.delegate) [self.delegate cameraSessionManagerDidReportAvailability:deviceAvailability forCameraType:cameraType];
}
*/



@end
