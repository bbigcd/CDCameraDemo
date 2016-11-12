//
//  CameraSessionView.h
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CACameraSessionDelegate <NSObject>

@optional
- (void)didCaptureImage:(UIImage *)image;
- (void)didCaptureImageWithData:(NSData *)imageData;

@end

@interface CameraSessionView : UIView

@property (nonatomic, weak) id <CACameraSessionDelegate> delegate;

- (void)setTopBarColor:(UIColor *)topBarColor;
- (void)hideFlashButton;
- (void)hideCameraToggleButton;
- (void)hideDismissButton;
- (void)onTapShutterButton;

@end
