//
//  CameraToggleButton.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "CameraToggleButton.h"

@implementation CameraToggleButton

- (void)drawRect:(CGRect)rect{
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    
    //// Subframes
    CGRect page1 = CGRectMake(CGRectGetMinX(self.bounds) + floor(CGRectGetWidth(self.bounds) * 0.02908 - 0.32) + 0.82, CGRectGetMinY(self.bounds) + floor(CGRectGetHeight(self.bounds) * 0.01817 + 0.13) + 0.37, floor(CGRectGetWidth(self.bounds) * 0.97408 - 0.32) - floor(CGRectGetWidth(self.bounds) * 0.02908 - 0.32), floor(CGRectGetHeight(self.bounds) * 0.98317 + 0.13) - floor(CGRectGetHeight(self.bounds) * 0.01817 + 0.13));
    
    
    //// Page-1
    {
        //// Portrait
        {
            CGContextSaveGState(context);
            CGContextSetAlpha(context, 0.8);
            CGContextBeginTransparencyLayer(context, NULL);
            
            
            //// CameraToggleVector Drawing
            UIBezierPath* cameraToggleVectorPath = UIBezierPath.bezierPath;
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.71159 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.26224 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.74989 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.28882 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.25052 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.26224 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.69811 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.28882 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.73432 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.25052 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.71159 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.69811 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.74989 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.73432 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.64822 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49827 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.58197 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.64822 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.42102 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.63816 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.64822 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.57553 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.58197 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.63816 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.35229 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49827 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.41853 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.63816 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.35229 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.57553 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.35229 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.42102 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.41853 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.61199 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49828 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56196 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.61199 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.43994 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.60391 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.61199 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55662 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56196 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.60391 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.38852 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49828 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43854 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.60391 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.38852 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55662 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.38852 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.43994 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43854 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.55331 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93945 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.46313 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.55331 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95963 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87890 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.55331 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91927 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.46313 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87890 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93945 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43560 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87890 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91927 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95963 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43560 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54376 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96935 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56951 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94150 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.55898 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95916 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56951 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94915 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.53831 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91011 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56951 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93296 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.55641 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.92149 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.93710 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49845 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.76177 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.89176 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.93710 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.71446 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.80324 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.20083 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.93710 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.38156 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.88576 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.27600 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56357 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08956 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.73905 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.14237 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.65600 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.10229 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56113 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06055 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56233 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.07897 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56113 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06849 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56380 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.02956 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56113 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.05211 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56248 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04081 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49845 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.80982 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.05919 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.25782 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54376 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96936 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.74557 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.79941 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94839 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54376 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96935 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43424 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96708 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49844 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.18917 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93664 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.73843 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.46250 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.02706 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.24931 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.20387 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04519 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.42790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06054 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.44266 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.03911 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.42790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.05148 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.45250 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08762 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.42790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06800 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.07770 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.06290 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49844 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.23344 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.11001 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.06290 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.28540 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43318 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.90687 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.06290 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.70518 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.22349 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87646 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43628 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94150 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43462 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91929 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43628 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93215 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43424 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96708 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43628 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94858 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43533 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95769 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43424 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96708 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            [cameraToggleVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44090 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06055 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.53107 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.44090 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08073 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.44090 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04037 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.53107 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06055 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.55860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04037 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08073 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.55860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1))];
            [cameraToggleVectorPath closePath];
            cameraToggleVectorPath.miterLimit = 4;
            
            cameraToggleVectorPath.usesEvenOddFillRule = YES;
            
            [color2 setFill];
            [cameraToggleVectorPath fill];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
    }
}


@end
