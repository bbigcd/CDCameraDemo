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
#import "PictureDetailViewController.h"
#import "ALAssetsLibrary+CDAssetsLibrary.h"

@interface Camera1ViewController ()<CACameraSessionDelegate>
{
    UIImage *_showImage;
}
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
//    [_cameraView hideFlashButton]; //On iPad flash is not present, hence it wont appear.
//    [_cameraView hideCameraToggleButton];
//    [_cameraView hideDismissButton];
    [self.view addSubview:_cameraView];
    
    [self setupDismissBtn];
    [self setupPicturePreview];
    [self getAllPhoto];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self onTapShutterButton];
//        [self getAllPhoto];
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)getAllPhoto{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library latestAsset:^(ALAsset * _Nullable asset, NSError * _Nullable error) {
        if (!error) {
            UIImage *thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
            _picturePreviewImageView.image = thumbnail;
        }
    }];
}

- (void)setupDismissBtn{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [bnt setFrame:CGRectMake(10, CGRectGetHeight(self.view.frame) - 72.5, 60, 60)];
    [bnt setTintColor:[UIColor whiteColor]];
    [bnt setTitle:@"取消" forState:UIControlStateNormal];
    [bnt addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnt];
}

- (void)onTapShutterButton{
    [_cameraView onTapShutterButton];
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 拍照成功预览
- (void)setupPicturePreview{
    _picturePreviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 72.5, CGRectGetHeight(self.view.frame) - 72.5, 62.5, 62.5)];
    _picturePreviewImageView.backgroundColor = [UIColor cyanColor];
    _picturePreviewImageView.contentMode = UIViewContentModeScaleToFill;
    _picturePreviewImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPictureDetailController)];
    [_picturePreviewImageView addGestureRecognizer:tap];
    [self.view addSubview:_picturePreviewImageView];
}

- (void)showPictureDetailController{
    PictureDetailViewController *vc = [[PictureDetailViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark --CACameraSessionDelegate--

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    [self.cameraView removeFromSuperview];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    _picturePreviewImageView.image = image;
    
    
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
    
    [self getAllPhoto];
}

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

- (void)dealloc{
    [self.cameraView removeFromSuperview];
}

@end
