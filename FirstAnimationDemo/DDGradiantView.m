//
//  DDGradiantView.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 1/1/16.
//  Copyright © 2016 dream. All rights reserved.
//

#import "DDGradiantView.h"

@implementation DDGradiantView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    CGContextRef myContext = UIGraphicsGetCurrentContext();
//    CGGradientRef myGradient;
//    CGColorSpaceRef myColorspace;
//    size_t num_locations = 2;
//    CGFloat locations[2] = { 0.0, 1.0 };
//    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,  // Start color
//        0.8, 0.8, 0.3, 1.0 }; // End color
//    
////    myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
//    myColorspace = CGColorSpaceCreateDeviceRGB();
//    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
//                                                      locations, num_locations);
//    
////    CGPoint myStartPoint, myEndPoint;
////    myStartPoint.x = 0.0;
////    myStartPoint.y = 0.0;
////    myEndPoint.x = 1.0;
////    myEndPoint.y = 1.0;
////    CGContextDrawLinearGradient (myContext, myGradient, myStartPoint, myEndPoint, 0);
//    
//    CGPoint myStartPoint, myEndPoint;
//    CGFloat myStartRadius, myEndRadius;
//    myStartPoint.x = 0.15;
//    myStartPoint.y = 0.15;
//    myEndPoint.x = 0.5;
//    myEndPoint.y = 0.5;
//    myStartRadius = 0.1;
//    myEndRadius = 0.25;
//    CGContextDrawRadialGradient (myContext, myGradient, myStartPoint,
//                                 myStartRadius, myEndPoint, myEndRadius,
//                                 kCGGradientDrawsAfterEndLocation);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIImage *image = [UIImage imageNamed:@"sample.jpg"];
//    CGContextTranslateCTM(context, 0, 300);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextDrawImage(context, CGRectMake(0, 0, 300, 300), image.CGImage);
    
//    CGCon
    
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    // 创建起点颜色
    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){1.0f, 0.01f, 0.01f, 0.3f});
    
    // 创建终点颜色
    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){1.0f, 0.01f, 0.01f, 0.0f});
    
    // 创建颜色数组
    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endColor}, 2, nil);
    
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
        0.0f,       // 对应起点颜色位置
        0.6f        // 对应终点颜色位置
    });
    
    // 释放颜色数组
    CFRelease(colorArray);
    
    // 释放起点和终点颜色
    CGColorRelease(beginColor);
    CGColorRelease(endColor);
    
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    
    CGGradientDrawingOptions options = kCGGradientDrawsAfterEndLocation;
    
//    CGContextDrawRadialGradient(context, gradientRef, CGPointMake(200.0f, 320.0f), 290.0f, CGPointMake(200.0f, 320.0f), 400.0f, options);
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(320.0f, 460.0f), 0);
    
    // 释放渐变对象
    CGGradientRelease(gradientRef);
}


@end
