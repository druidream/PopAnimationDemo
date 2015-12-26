//
//  BackgroundPlayer.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/21/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "BackgroundPlayer.h"
#import "AVFoundation/AVAudioSession.h"
#import "UIKit/UIViewController.h"

@implementation BackgroundPlayer
@synthesize player;

static BackgroundPlayer *instance = nil;

+ (BackgroundPlayer *)sharedInstance
{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[BackgroundPlayer alloc] init];
        });
    }
    return instance;
}

- (BOOL)isPlaying
{
    if (player) {
        return [player isPlaying];
    }
    return NO;
}

- (void)play
{
    if ([self isPlaying]) {
        return;
    }
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Silent Roar-euphoria" withExtension:@"mp3"] error:nil];
    [player prepareToPlay];
    [player setMeteringEnabled:YES];
    [player play];
    
    // NSTimer running in background thread
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sendCurrentProgress:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run]    ;
}

- (float)normalizedPowerLevel
{
    [player updateMeters];
    
    CGFloat normalizedValue;
    normalizedValue = [self _normalizedPowerLevelFromDecibels:[player averagePowerForChannel:0]];
    return normalizedValue;
}

- (float)progress
{
    return player.currentTime/player.duration;
}

- (NSTimeInterval)currentTime
{
    return player.currentTime;
}

- (NSTimeInterval)duration
{
    return player.duration;
}

#pragma mark - private

- (void)sendCurrentProgress:(NSTimer *)timer
{
    [_delegate currentTime:player.currentTime withDuration:player.duration];
}

- (CGFloat)_normalizedPowerLevelFromDecibels:(CGFloat)decibels
{
    if (decibels < -60.0f || decibels == 0.0f) {
        return 0.0f;
    }
    
    return powf((powf(10.0f, 0.05f * decibels) - powf(10.0f, 0.05f * -60.0f)) * (1.0f / (1.0f - powf(10.0f, 0.05f * -60.0f))), 1.0f / 2.0f);
}

@end
