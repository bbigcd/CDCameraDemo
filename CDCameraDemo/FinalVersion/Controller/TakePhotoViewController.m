//
//  TakePhotoViewController.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "CameraSessionView.h"
#import "ALAssetsLibrary+CDAssetsLibrary.h"
#import "PhotoDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

@interface TakePhotoViewController ()<CACameraSessionDelegate>

@property (nonatomic, strong) CameraSessionView *cameraView;

@property (nonatomic, strong) UIImage *showImage;
@property (nonatomic, strong) UIImageView *picturePreviewImageView;//预览

@end

@implementation TakePhotoViewController

static void *AuthorizationStatusKey = @"AuthorizationStatusKey";

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNeedsStatusBarAppearanceUpdate];
    // 判断应用是否获取相机权限
    [self checkAuthorizationStatus];
    
    //初始化
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];

    _cameraView.delegate = self;
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.6];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[_cameraView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    [self.view addSubview:_cameraView];
    
    [self setupDismissBtn];
    [self setupPicturePreview];
    [self getLatestPicture];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)checkAuthorizationStatus{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    ALAuthorizationStatus photoAuthStatus = [ALAssetsLibrary authorizationStatus];
    
    if(videoAuthStatus == ALAuthorizationStatusRestricted ||
       videoAuthStatus == ALAuthorizationStatusDenied ||
       photoAuthStatus == ALAuthorizationStatusDenied){
        NSLog(@"H band访问相机或相册权限受到限制");
        NSString *title = @"H band访问相机或相册权限受到限制";
        
        NSString *sure = @"Settings";
        NSString *cancel = @"Cancel";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:cancel otherButtonTitles:sure, nil];
        void (^block)(NSInteger) = ^(NSInteger buttonIndex)
        {
            if (buttonIndex == 0) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                // 跳转应用设置开启权限
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        };
        objc_setAssociatedObject(alertView, AuthorizationStatusKey, block, OBJC_ASSOCIATION_COPY);
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, AuthorizationStatusKey);
    block(buttonIndex);
}

- (void)getLatestPicture{
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
    bnt.titleLabel.adjustsFontSizeToFitWidth = YES;
    [bnt setTitle:@"Cancel" forState:UIControlStateNormal];
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
    PhotoDetailViewController *vc = [[PhotoDetailViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark -- CACameraSessionDelegate --

- (void)didCaptureImage:(UIImage *)image{
    NSLog(@"获得image数据");
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)didCaptureImageWithData:(NSData *)imageData{
    NSLog(@"获得image的data数据");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error){
        NSLog(@"H band访问相机或相册权限受到限制");
    }
    
    [self getLatestPicture];
}

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    [self.cameraView removeFromSuperview];
}


@end
