//
//  CameraViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/7.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    1.使用前应先判断是否可用
    //照相机是否可用
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    //相册是否可用
    BOOL isPhotoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
//    2.初始化UIImagePickerController
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
//    3.设置picker的类型（只能设置一个）
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//设置为此即打开相册
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置为此即打开相机
    
    //    4.设置回调代理（用于选中图片或者拍照完成后回图片的各种信息）
    //注意：此处需要遵循两个代理协议
    //UIImagePickerControllerDelegate 用于选择照片或拍照后回调
    //UINavigationControllerDelegate 在相机/相册选择中会有Nav进行跳转，此代理可以用于监听事件
    
    picker.delegate = self;
    
    //    5.弹出相机/相册（一定要使用modal形式才可弹出）
//    [self presentViewController:picker animated:YES completion:nil];
    [self presentViewController:picker animated:YES completion:NULL];
    
}

//    6.实现代理监听相机/相册回调
#pragma mark - UIImageViewPickerDelegate 相机/相册 回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //选择完成后dismiss选择控制器，同时处理选择的图
    [picker dismissViewControllerAnimated:YES completion:^
     {
         //info中有选中图片的全部信息，根据需要去获取，此处获取的为原图
         UIImage *choiceImage = [info objectForKey:UIImagePickerControllerOriginalImage];
         
         if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
         {
             //若为相机拍摄则保存到相册
             UIImageWriteToSavedPhotosAlbum(choiceImage, NULL, NULL, NULL);
         }
     }];
}

@end
