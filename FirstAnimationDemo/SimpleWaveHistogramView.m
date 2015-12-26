//
//  SimpleWaveHistogramView.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/23/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SimpleWaveHistogramView.h"

@implementation SimpleWaveHistogramView
@synthesize size, barWidth, timer;

- (void)startAnimating
{
    [self setHidden:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
}

- (void)stopAnimating
{
    [self setHidden:YES];
    [timer invalidate];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (size.width == 0 || size.height == 0) {
        size = CGSizeMake(12, 12);
    }
    if (barWidth == 0) {
        barWidth = 3;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor (ctx, 0.3, 0.3, 0.3, 1.0);
    // first bar
    CGFloat randomHeight = [self _randomHeight];
    CGContextFillRect(ctx, CGRectMake(0, size.height - randomHeight, barWidth, randomHeight));
    
    // second bar
    randomHeight = [self _randomHeight];
    CGContextFillRect(ctx, CGRectMake(size.width /2 - barWidth / 2, size.height - randomHeight, barWidth, randomHeight));
    
    // third bar
    randomHeight = [self _randomHeight];
    CGContextFillRect(ctx, CGRectMake(size.width - barWidth, size.height - randomHeight, barWidth, randomHeight));
    
    CGContextStrokePath(ctx);
}

- (CGFloat)_randomHeight
{
    return ((arc4random() % 80 + 20) / 100.0) * size.height;
}

@end
