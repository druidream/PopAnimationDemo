//
//  BackgroundImageProcessor.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 1/16/16.
//  Copyright © 2016 dream. All rights reserved.
//

#import "BackgroundImageProcessor.h"
#import "GPUImageRGBFilter.h"
#import "GPUImageiOSBlurFilter.h"
#import "DDGradiantView.h"

@implementation BackgroundImageProcessor
@synthesize backgroundImage;
static BackgroundImageProcessor *instance = nil;

+ (BackgroundImageProcessor *)sharedInstance
{
    
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[BackgroundImageProcessor alloc] init];
        });
    }
    return instance;
}

- (UIImage *)bg {
    if (!backgroundImage) {
        UIImage *image = [UIImage imageNamed:@"sample.jpg"];
        GPUImageRGBFilter *f = [[GPUImageRGBFilter alloc]init];
        f.red = 0.6;
        f.green = 0.6;
        f.blue = 0.9;
        UIImage *filteredImg = [f imageByFilteringImage:image];
        GPUImageiOSBlurFilter * blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 1;
        blurFilter.downsampling = 8.0;
        UIImage *blurredImage = [blurFilter imageByFilteringImage:filteredImg];
        backgroundImage = blurredImage;
    }
    return backgroundImage;
}

@end
