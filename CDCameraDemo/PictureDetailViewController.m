//
//  PictureDetailViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/9.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "PictureDetailViewController.h"

@interface PictureDetailViewController ()

@end

@implementation PictureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
