//
//  Camera3ViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/8.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "Camera3ViewController.h"
#import "CaptureSessionManager.h"


@interface Camera3ViewController ()
<CaptureSessionManagerDelegate>

@property (nonatomic, strong) CaptureSessionManager *captureManager;

@end

@implementation Camera3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Camera Session Manager Delegate Methods

-(void)cameraSessionManagerDidCaptureImage{
    
}

-(void)cameraSessionManagerFailedToCaptureImage {
    
}

-(void)cameraSessionManagerDidReportAvailability:(BOOL)deviceAvailability forCameraType:(CameraType)cameraType {
    
}

-(void)cameraSessionManagerDidReportDeviceStatistics:(CameraStatistics)deviceStatistics {
    
}

@end
