//
//  Camera1ViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/7.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "Camera1ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CameraSessionView.h"

@interface Camera1ViewController ()<CACameraSessionDelegate>

@property (nonatomic, strong) CameraSessionView *cameraView;
@property (nonatomic, strong) UIImageView *picturePreviewImageView;//预览

@end

@implementation Camera1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Instantiate the camera view & assign its frame
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    
    //Set the camera view's delegate and add it as a subview
    _cameraView.delegate = self;
    
    //Apply animation effect to present the camera view
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.6];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[_cameraView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    [_cameraView setTopBarColor:[UIColor darkGrayColor]];
    [_cameraView hideFlashButton]; //On iPad flash is not present, hence it wont appear.
    [_cameraView hideCameraToggleButton];
    [_cameraView hideDismissButton];
    [self.view addSubview:_cameraView];
    
    [self setupPicturePreview];
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


- (void)showPictureDetailController{
    NSLog(@"show picture");
}

#pragma mark --CACameraSessionDelegate--

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    [self.cameraView removeFromSuperview];
//    [self dismissViewControllerAnimated:YES completion:nil];
    _picturePreviewImageView.image = image;
    
}

-(void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"CAPTURED IMAGE DATA");
    //UIImage *image = [[UIImage alloc] initWithData:imageData];
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //[self.cameraView removeFromSuperview];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
