//
//  CameraSessionView.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "CameraSessionView.h"
#import "CaptureSessionManager.h"
#import <ImageIO/ImageIO.h>
#import "Constants.h"
#import "CameraShutterButton.h"
#import "CameraFlashButton.h"
#import "CameraToggleButton.h"
#import "CameraFocalReticule.h"

@interface CameraSessionView()<CaptureSessionManagerDelegate>
{
    // 根据屏幕改变icon的大小
    CGSize shutterButtonSize;
    CGSize barButtonItemSize;
    
    // 前置后置摄像头转换
    CameraType cameraBeingUsed;
}

@property (readwrite) BOOL animationInProgress;

@property (nonatomic, strong) CaptureSessionManager *captureManager;

// 界面按钮
@property (nonatomic, strong) CameraShutterButton *cameraShutter;
@property (nonatomic, strong) CameraFlashButton *cameraFlash;
@property (nonatomic, strong) CameraToggleButton *cameraToggle;
@property (nonatomic, strong) CameraFocalReticule *focalReticule;

@end

@implementation CameraSessionView

- (void)drawRect:(CGRect)rect{
    if (self) {
        _animationInProgress = NO;
        [self setupCaptureManager:RearFacingCamera];
        cameraBeingUsed = RearFacingCamera;
        [self composeInterface];
        [_captureManager.captureSession startRunning];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}

#pragma mark - Setup
- (void)setupCaptureManager:(CameraType)camera{
    // 删除现有的输入设备
    AVCaptureInput* currentCameraInput = [self.captureManager.captureSession.inputs objectAtIndex:0];
    [self.captureManager.captureSession removeInput:currentCameraInput];
    
    _captureManager = nil;
    
    // 创建被配置'CaptureSessionManager'
    _captureManager = [[CaptureSessionManager alloc] init];
    
    // 开始配置session
    [self.captureManager.captureSession beginConfiguration];
    
    if (_captureManager) {
        
        [_captureManager setDelegate:self];
        [_captureManager initiateCaptureSessionForCamera:camera];
        [_captureManager addStillImageOutput];
        [_captureManager addVideoPreviewLayer];
        [self.captureManager.captureSession commitConfiguration];
        
        // 设置实时预览view
        CGRect layerRect = self.layer.bounds;
        [_captureManager.previewLayer setBounds:layerRect];
        [_captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
        
        // 相机预览层layer动效
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.6];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [_captureManager.previewLayer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
        
        // 展示预览层
        [self.layer addSublayer:_captureManager.previewLayer];
    }
}

- (void)composeInterface{
    shutterButtonSize = CGSizeMake(self.bounds.size.width * 0.21, self.bounds.size.width * 0.21);
    barButtonItemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.height * 0.05, [[UIScreen mainScreen] bounds].size.height * 0.05);
    
    
    
    if (_captureManager) {
        // 拍照按钮
        _cameraShutter = [[CameraShutterButton alloc] init];
        _cameraShutter.frame = (CGRect){0,0, shutterButtonSize};
        _cameraShutter.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 45);
        _cameraShutter.backgroundColor = [UIColor clearColor];
        _cameraShutter.tag = ShutterButtonTag;
        [_cameraShutter addTarget:self action:@selector(buttonTapManager:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cameraShutter];
        
        // 闪光灯
        _cameraFlash = [[CameraFlashButton alloc] init];
        _cameraFlash.frame = (CGRect){0,0, barButtonItemSize};
        _cameraFlash.center = CGPointMake(40, 45);
        _cameraFlash.tag = FlashButtonTag;
        [_cameraFlash addTarget:self action:@selector(buttonTapManager:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cameraFlash];
    
        // 切换摄像头
        _cameraToggle = [[CameraToggleButton alloc] init];
        _cameraToggle.frame = (CGRect){0,0, barButtonItemSize};
        _cameraToggle.center = CGPointMake(CGRectGetWidth(self.frame) - 40, 45);
        _cameraToggle.tag = ToggleButtonTag;
        [_cameraToggle addTarget:self action:@selector(buttonTapManager:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cameraToggle];
        
        // 聚焦按钮
        _focalReticule = [[CameraFocalReticule alloc] init];
        _focalReticule.frame = (CGRect){0,0, 60, 60};
        _focalReticule.backgroundColor = [UIColor clearColor];
        _focalReticule.hidden = YES;
        [self addSubview:_focalReticule];
        
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusGesture:)];
        [self addGestureRecognizer:singleTapGestureRecognizer];
    }
}


#pragma mark -- 用户交互 --

- (void)buttonTapManager:(id)sender{
    if (_animationInProgress){
        return;
    }
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    switch ([(UIButton *)sender tag]) {
        case ShutterButtonTag:  [self onTapShutterButton];  return;
        case ToggleButtonTag:   [self onTapToggleButton];   return;
        case FlashButtonTag:    [self onTapFlashButton];    return;
    }
}

- (void)onTapShutterButton{
    [self animateShutterRelease];
    [_captureManager captureStillImage];
}

- (void)onTapFlashButton{
//    BOOL enable = !self.captureManager.isTorchEnabled;
//    self.captureManager.enableTorch = enable;
    
    [_captureManager setCameraFlashModel:FlashCurrentStateAuto];
}

- (void)onTapToggleButton{
    if (cameraBeingUsed == RearFacingCamera) {
        [self setupCaptureManager:FrontFacingCamera];
        cameraBeingUsed = FrontFacingCamera;
        [self composeInterface];
        [[_captureManager captureSession] startRunning];
        NSLog(@"前置摄像头");
        _cameraFlash.hidden = YES;
    } else {
        [self setupCaptureManager:RearFacingCamera];
        cameraBeingUsed = RearFacingCamera;
        [self composeInterface];
        [[_captureManager captureSession] startRunning];
        NSLog(@"后置摄像头");
        _cameraFlash.hidden = NO;
    }
}

- (void)focusGesture:(id)sender {
    
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = sender;
        if (tap.state == UIGestureRecognizerStateRecognized) {
            CGPoint location = [sender locationInView:self];
            
            [self focusAtPoint:location completionHandler:^{
                [self animateFocusReticuleToPoint:location];
            }];
        }
    }
}

#pragma mark -- Animation --
- (void)animateShutterRelease{
    
    _animationInProgress = YES; //禁用输入管理
    
    [UIView animateWithDuration:.1 animations:^{
        _cameraShutter.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            _cameraShutter.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
            _animationInProgress = NO; //启用输入管理
        }];
    }];
}

- (void)animateFocusReticuleToPoint:(CGPoint)targetPoint
{
    _animationInProgress = YES; //禁用输入管理
    
    [_focalReticule setCenter:targetPoint];
    _focalReticule.alpha = 0.0;
    _focalReticule.hidden = NO;
    
    [UIView animateWithDuration:0.4 animations:^{
        _focalReticule.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            _focalReticule.alpha = 0.0;
        }completion:^(BOOL finished) {
            
            _animationInProgress = NO; //启用输入管理
        }];
    }];
}

#pragma mark -- Camera Session Manager Delegate Methods --

- (void)cameraSessionManagerDidCaptureImage
{
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(didCaptureImage:)]){
            [self.delegate didCaptureImage:[_captureManager stillImage]];
        }
        if ([self.delegate respondsToSelector:@selector(didCaptureImageWithData:)]){
            [self.delegate didCaptureImageWithData:[_captureManager stillImageData]];
        }
    }
}

- (void)cameraSessionManagerFailedToCaptureImage{
    
}

- (void)cameraSessionManagerDidReportAvailability:(BOOL)deviceAvailability forCameraType:(CameraType)cameraType {
    
}

- (void)cameraSessionManagerDidReportDeviceStatistics:(CameraStatistics)deviceStatistics{
    
}

#pragma mark -- 工具方法 --

- (void)focusAtPoint:(CGPoint)point completionHandler:(void(^)())completionHandler
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];;
    CGPoint pointOfInterest = CGPointZero;
    CGSize frameSize = self.bounds.size;
    pointOfInterest = CGPointMake(point.y / frameSize.height, 1.f - (point.x / frameSize.width));
    
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        
        //Lock camera for configuration if possible
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            
            if ([device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
                [device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
            }
            
            if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                [device setFocusPointOfInterest:pointOfInterest];
            }
            
            if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                [device setExposurePointOfInterest:pointOfInterest];
                [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            }
            
            [device unlockForConfiguration];
            
            completionHandler();
        }
    }
    else { completionHandler(); }
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (BOOL)shouldAutorotate
{
    return NO;
}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

//- (void)viewDidDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
//}

#pragma mark -- 公共方法 --

- (void)setTopBarColor:(UIColor *)topBarColor
{
//    _topBarView.backgroundColor = topBarColor;
}

- (void)hideFlashButton
{
//    _cameraFlash.hidden = YES;
}

- (void)hideCameraToggleButton
{
//    _cameraToggle.hidden = YES;
}

- (void)hideDismissButton
{
    //    _cameraDismiss.hidden = YES;
}





- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
