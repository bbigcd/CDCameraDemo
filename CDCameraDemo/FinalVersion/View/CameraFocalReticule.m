//
//  CameraFocalReticule.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "CameraFocalReticule.h"

@implementation CameraFocalReticule

- (void)drawRect:(CGRect)rect{
    
    //// Color Declarations
    UIColor* color0 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color6 = [UIColor colorWithRed: 0.521 green: 0.521 blue: 0.521 alpha: 1];
    
    
    //// Subframes
    CGRect page1 = CGRectMake(CGRectGetMinX(self.bounds) + floor(CGRectGetWidth(self.bounds) * 0.03763 - 0.03) + 0.53, CGRectGetMinY(self.bounds) + floor(CGRectGetHeight(self.bounds) * 0.03815 + 0.13) + 0.37, floor(CGRectGetWidth(self.bounds) * 0.96263 - 0.03) - floor(CGRectGetWidth(self.bounds) * 0.03763 - 0.03), floor(CGRectGetHeight(self.bounds) * 0.96315 + 0.13) - floor(CGRectGetHeight(self.bounds) * 0.03815 + 0.13));
    
    
    //// Page-1
    {
        //// Portrait
        {
            //// Group 4
            {
                //// Rectangle-6 Drawing
                UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(page1) + floor(CGRectGetWidth(page1) * 0.00000 + 0.5), CGRectGetMinY(page1) + floor(CGRectGetHeight(page1) * 0.00000 + 0.5), floor(CGRectGetWidth(page1) * 1.00000 + 0.5) - floor(CGRectGetWidth(page1) * 0.00000 + 0.5), floor(CGRectGetHeight(page1) * 1.00000 + 0.5) - floor(CGRectGetHeight(page1) * 0.00000 + 0.5))];
                [color6 setStroke];
                rectangle6Path.lineWidth = 3;
                [rectangle6Path stroke];
                
                
                //// Rectangle-2 Drawing
                UIBezierPath* rectangle2Path = UIBezierPath.bezierPath;
                [rectangle2Path moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.10711 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06860 * CGRectGetHeight(page1))];
                [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.89268 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06860 * CGRectGetHeight(page1))];
                [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.83737 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12403 * CGRectGetHeight(page1))];
                [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.16245 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12403 * CGRectGetHeight(page1))];
                [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.10711 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06860 * CGRectGetHeight(page1))];
                [rectangle2Path closePath];
                rectangle2Path.miterLimit = 4;
                
                rectangle2Path.usesEvenOddFillRule = YES;
                
                [color0 setFill];
                [rectangle2Path fill];
                
                
                //// Rectangle-4 Drawing
                UIBezierPath* rectangle4Path = UIBezierPath.bezierPath;
                [rectangle4Path moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.93140 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.10715 * CGRectGetHeight(page1))];
                [rectangle4Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.93140 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.89279 * CGRectGetHeight(page1))];
                [rectangle4Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.87597 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.83746 * CGRectGetHeight(page1))];
                [rectangle4Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.87597 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.16255 * CGRectGetHeight(page1))];
                [rectangle4Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.93140 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.10715 * CGRectGetHeight(page1))];
                [rectangle4Path closePath];
                rectangle4Path.miterLimit = 4;
                
                rectangle4Path.usesEvenOddFillRule = YES;
                
                [color0 setFill];
                [rectangle4Path fill];
                
                
                //// Rectangle-8 Drawing
                UIBezierPath* rectangle8Path = UIBezierPath.bezierPath;
                [rectangle8Path moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.06860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.89279 * CGRectGetHeight(page1))];
                [rectangle8Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.06860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.10717 * CGRectGetHeight(page1))];
                [rectangle8Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.12403 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.16274 * CGRectGetHeight(page1))];
                [rectangle8Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.12403 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.83738 * CGRectGetHeight(page1))];
                [rectangle8Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.06860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.89279 * CGRectGetHeight(page1))];
                [rectangle8Path closePath];
                rectangle8Path.miterLimit = 4;
                
                rectangle8Path.usesEvenOddFillRule = YES;
                
                [color0 setFill];
                [rectangle8Path fill];
                
                
                //// Rectangle-5 Drawing
                UIBezierPath* rectangle5Path = UIBezierPath.bezierPath;
                [rectangle5Path moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.89293 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93140 * CGRectGetHeight(page1))];
                [rectangle5Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.10727 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93140 * CGRectGetHeight(page1))];
                [rectangle5Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.16282 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87597 * CGRectGetHeight(page1))];
                [rectangle5Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.83743 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87597 * CGRectGetHeight(page1))];
                [rectangle5Path addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.89293 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93140 * CGRectGetHeight(page1))];
                [rectangle5Path closePath];
                rectangle5Path.miterLimit = 4;
                
                rectangle5Path.usesEvenOddFillRule = YES;
                
                [color0 setFill];
                [rectangle5Path fill];
            }
        }
    }
}

@end
