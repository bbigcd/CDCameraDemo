//
//  CameraFlashButton.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "CameraFlashButton.h"

@implementation CameraFlashButton

- (void)drawRect:(CGRect)rect{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    
    //// Subframes
    CGRect page1 = CGRectMake(CGRectGetMinX(self.bounds) + floor(CGRectGetWidth(self.bounds) * 0.16636 + 0.23) + 0.27, CGRectGetMinY(self.bounds) + floor(CGRectGetHeight(self.bounds) * 0.03852 + 0.2) + 0.3, floor(CGRectGetWidth(self.bounds) * 0.83136 + 0.23) - floor(CGRectGetWidth(self.bounds) * 0.16636 + 0.23), floor(CGRectGetHeight(self.bounds) * 0.96352 + 0.2) - floor(CGRectGetHeight(self.bounds) * 0.03852 + 0.2));
    
    
    //// Page-1
    {
        //// Portrait
        {
            CGContextSaveGState(context);
            CGContextSetAlpha(context, 0.8);
            CGContextBeginTransparencyLayer(context, NULL);
            
            
            //// FlashVector Drawing
            UIBezierPath* flashVectorPath = UIBezierPath.bezierPath;
            [flashVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.17944 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.45268 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.45896 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55598 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.90397 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55854 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.64845 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.45124 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
            [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
            [flashVectorPath closePath];
            flashVectorPath.miterLimit = 4;
            
            flashVectorPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [flashVectorPath fill];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
    }
}

@end
