//
//  Camera2ViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/8.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "Camera2ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PictureDetailViewController.h"
#import <ImageIO/ImageIO.h>

typedef NS_ENUM(BOOL, CameraType) {
    FrontFacingCamera,
    RearFacingCamera,
};

@interface Camera2ViewController ()
//<AVCaptureFileOutputRecordingDelegate>
{
    AVCaptureSession *_captureSession;
    AVCaptureDevice *_videoDevice;
    AVCaptureVideoPreviewLayer *_previewLayer;
    AVCaptureStillImageOutput *_stillImageOutput;
    CameraType cameraBeingUsed;
}
@property (nonatomic, strong) UIImage *stillImage;
@property (nonatomic, strong) NSData *stillImageData;

@property (nonatomic, strong) UIButton *falshBtn;//闪光灯
@property (nonatomic, strong) UIButton *toggleBtn;//前后切换
@property (nonatomic, strong) UIButton *shutterBtn;//拍照
@property (nonatomic, strong) UIButton *dismissBtn;//退出拍照
@property (nonatomic, strong) UIButton *focalReticuleBtn;//聚焦
@property (nonatomic, strong) UIImageView *picturePreviewImageView;//预览
@property (nonatomic, assign, getter = isTorchEnabled) BOOL enableTorch;
@end

@implementation Camera2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCaptureSession];
    
    [_captureSession beginConfiguration];
    
    [self setupVideoInput];
    [self setupPreviewLayer];
    [self setupStillImageOutput];
    
    [_captureSession commitConfiguration];
    
    //开启会话-->(不等于开始录制)
    [_captureSession startRunning];
    
    [self setupButtons];
    [self setupPicturePreview];
}

#pragma mark -- 界面UI --

- (UIButton *)initializeSimilarWithTitle:(NSString *)title WithFrame:(CGRect)frame WithSEL:(SEL)selector{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [bnt setFrame:frame];
    [bnt setTitle:title forState:UIControlStateNormal];
    [bnt addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnt];
    return bnt;
}

- (void)setupButtons{
    self.falshBtn = [self initializeSimilarWithTitle:@"⚡︎" WithFrame:CGRectMake(10, 25 , 60, 60) WithSEL:@selector(onTapFlashButton)];
    self.toggleBtn = [self initializeSimilarWithTitle:@"⌘" WithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 80, 25, 60, 60) WithSEL:@selector(onTapToggleButton)];
    self.dismissBtn = [self initializeSimilarWithTitle:@"取消" WithFrame:CGRectMake(10, CGRectGetHeight(self.view.frame) - 80, 60, 60) WithSEL:@selector(dismissViewController)];
    self.shutterBtn = [self initializeSimilarWithTitle:@"拍照" WithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 30, CGRectGetHeight(self.view.frame) - 80 , 60, 60) WithSEL:@selector(takePhotoManager)];
}

// 闪光灯切换
- (void)onTapFlashButton{
    _enableTorch = !self.isTorchEnabled;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash])
    {
        [device lockForConfiguration:nil];
        if (_enableTorch) {
            [device setTorchMode:AVCaptureTorchModeOn];
        }else{
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

// 切换摄像头
- (void)onTapToggleButton{
    BOOL isFrontFacingCamera = NO;
    if (isFrontFacingCamera) {
        cameraBeingUsed = FrontFacingCamera;
    }else{
        cameraBeingUsed = RearFacingCamera;
    }
    
    // 后置
    AVCaptureInput *currentCameraInput = [_captureSession.inputs objectAtIndex:0];
    [_captureSession removeInput:currentCameraInput];
    [self initiateCaptureSessionForCamera:cameraBeingUsed];
    [self setupPreviewLayer];
//    [self setupStillImageOutput];
    
    [_captureSession beginConfiguration];
    
    
    [_captureSession commitConfiguration];
    
    // 前置
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)takePhotoManager{
    [UIView animateWithDuration:.1 animations:^{
        _shutterBtn.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            _shutterBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
//            _animationInProgress = NO; //Enables input manager
        }];
    }];
    [self captureStillImage];
}

- (void)showPictureDetailController{
    PictureDetailViewController *vc = [[PictureDetailViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

// 拍照成功预览
- (void)setupPicturePreview{
    _picturePreviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 70, CGRectGetHeight(self.view.frame) - 90, 60, 80)];
    _picturePreviewImageView.backgroundColor = [UIColor cyanColor];
    _picturePreviewImageView.contentMode = UIViewContentModeScaleToFill;
    _picturePreviewImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPictureDetailController)];
    [_picturePreviewImageView addGestureRecognizer:tap];
    
    [self.view addSubview:_picturePreviewImageView];
}

#pragma mark -- AVCaptureSession各个配置 --

// 1.session回话设置
- (void)setupCaptureSession{
    _captureSession = [[AVCaptureSession alloc] init];
    _videoDevice = [self deviceWithModeiaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
}

// 2.调取摄像头
- (void)setupVideoInput{
    NSError *error;
    AVCaptureDeviceInput *cameraDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_videoDevice error:&error];
    if (error) {
        NSLog(@"--- 取摄像头的时候出错 --- %@", error);
        return;
    }
    
    if ([_captureSession canAddInput:cameraDeviceInput]) {
        [_captureSession addInput:cameraDeviceInput];
    }
}

// 3.预览view
- (void)setupPreviewLayer{
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    _previewLayer.frame = self.view.layer.bounds;
    _previewLayer.position = CGPointMake(self.view.bounds.size.width*0.5,self.view.bounds.size.height*0.5);
    CALayer *layer = self.view.layer;
    layer.masksToBounds = true;
    [self.view layoutIfNeeded];
    [layer addSublayer:_previewLayer];
}

// 4.图片输出
- (void)setupStillImageOutput{
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

- (void)initiateCaptureSessionForCamera:(CameraType)cameraType {
    
    //Iterate through devices and assign 'active camera' per parameter
    for (AVCaptureDevice *device in AVCaptureDevice.devices) if ([device hasMediaType:AVMediaTypeVideo]) {
        switch (cameraType) {
            case RearFacingCamera:
                if ([device position] == AVCaptureDevicePositionBack){
                    _videoDevice = device;
                }
                break;
            case FrontFacingCamera:
                if ([device position] == AVCaptureDevicePositionFront){
                    _videoDevice = device;
                }
                break;
        }
    }
    
    NSError *error          = nil;
    BOOL deviceAvailability = YES;
    
    AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_videoDevice error:&error];
    if (!error && [_captureSession canAddInput:cameraDeviceInput]){
        [_captureSession addInput:cameraDeviceInput];
    }else{
        deviceAvailability = NO;
    }
    
    
}

/*
-(void)setupCaptureManager:(CameraType)camera {
    
    // remove existing input
    AVCaptureInput* currentCameraInput = [_captureSession.inputs objectAtIndex:0];
    [_captureSession removeInput:currentCameraInput];
    
    _captureManager = nil;
    
    //Create and configure 'CaptureSessionManager' object
    _captureManager = [CaptureSessionManager new];
    
    // indicate that some changes will be made to the session
    [_captureSession beginConfiguration];
    
    if (_captureManager) {
        
        //Configure
        [_captureManager setDelegate:self];
        [_captureManager initiateCaptureSessionForCamera:camera];
        [_captureManager addStillImageOutput];
        [_captureManager addVideoPreviewLayer];
        [_captureSession commitConfiguration];
        
        //Preview Layer setup
        CGRect layerRect = self.layer.bounds;
        [_captureManager.previewLayer setBounds:layerRect];
        [_captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
        
        //Apply animation effect to the camera's preview layer
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.6];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [_captureManager.previewLayer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
        
        //Add to self.view's layer
        [self.layer addSublayer:_captureManager.previewLayer];
    }
}
*/

#pragma mark - Helper Method(s)

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
             [self setStillImage:image];
             [self setStillImageData:imageData];
             [_picturePreviewImageView setImage:image];
             
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
             });
             
         }];
    }
    
    //Turn off the flash if on
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

- (AVCaptureConnection *)getOrientationAdaptedCaptureConnection{
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
    [videoConnection setVideoOrientation:newOrientation];
}


- (AVCaptureDevice *)deviceWithModeiaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)positon{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = devices.firstObject;
    for (AVCaptureDevice *device in devices) {
        if (device.position == positon) {
            captureDevice = device;
            break;
        }
    }
    return captureDevice;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error){
        [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }else{
        NSLog(@"存入照片成功");
    }
}

@end
