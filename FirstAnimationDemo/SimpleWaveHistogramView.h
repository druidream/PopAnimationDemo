//
//  SimpleWaveHistogramView.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/23/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleWaveHistogramView : UIView

@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat barWidth;
@property (nonatomic) NSTimer *timer;

- (void)startAnimating;
- (void)stopAnimating;

@end
