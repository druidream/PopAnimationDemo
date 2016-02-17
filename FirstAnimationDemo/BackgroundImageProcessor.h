//
//  BackgroundImageProcessor.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 1/16/16.
//  Copyright © 2016 dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BackgroundImageProcessor : NSObject

+ (BackgroundImageProcessor *)sharedInstance;

- (UIImage *)bg;
@property (nonatomic, retain) UIImage *backgroundImage;

@end
