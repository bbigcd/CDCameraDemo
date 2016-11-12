//
//  CameraShutterButton.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "CameraShutterButton.h"

@implementation CameraShutterButton

- (void)drawRect:(CGRect)rect{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color0 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color1 = [UIColor colorWithRed: 0.812 green: 0.812 blue: 0.812 alpha: 0.62];
    
    
    //// Subframes
    CGRect page1 = CGRectMake(CGRectGetMinX(self.bounds) + floor(CGRectGetWidth(self.bounds) * 0.03691 + 0.12) + 0.38, CGRectGetMinY(self.bounds) + floor(CGRectGetHeight(self.bounds) * 0.03466 + 0.43) + 0.07, floor(CGRectGetWidth(self.bounds) * 0.96691 + 0.12) - floor(CGRectGetWidth(self.bounds) * 0.03691 + 0.12), floor(CGRectGetHeight(self.bounds) * 0.96466 + 0.43) - floor(CGRectGetHeight(self.bounds) * 0.03466 + 0.43));
    
    
    //// Page-1
    {
        //// Portrait
        {
            CGContextSaveGState(context);
            CGContextSetAlpha(context, 0.62);
            CGContextBeginTransparencyLayer(context, NULL);
            
            
            //// CameraShutterVector Drawing
            UIBezierPath* cameraShutterVectorPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(page1) + floor(CGRectGetWidth(page1) * 0.00000 + 0.5), CGRectGetMinY(page1) + floor(CGRectGetHeight(page1) * 0.00000 + 0.5), floor(CGRectGetWidth(page1) * 1.00000 + 0.5) - floor(CGRectGetWidth(page1) * 0.00000 + 0.5), floor(CGRectGetHeight(page1) * 1.00000 + 0.5) - floor(CGRectGetHeight(page1) * 0.00000 + 0.5))];
            [color1 setFill];
            [cameraShutterVectorPath fill];
            [color0 setStroke];
            cameraShutterVectorPath.lineWidth = 3;
            [cameraShutterVectorPath stroke];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
    }
}

@end
