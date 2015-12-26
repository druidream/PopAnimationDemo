//
//  BackgroundPlayer.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/21/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVAudioPlayer.h"

@protocol PlayerDelegate <NSObject>

@required
- (void)currentTime:(NSTimeInterval)time withDuration:(NSTimeInterval)duration;

@end

@interface BackgroundPlayer : NSObject

+ (BackgroundPlayer *)sharedInstance;
- (BOOL)isPlaying;
- (void)play;
- (float)normalizedPowerLevel;
- (float)progress;
- (NSTimeInterval)currentTime;
- (NSTimeInterval)duration;

@property (weak, nonatomic) id<PlayerDelegate> delegate;
@property (nonatomic, retain) AVAudioPlayer *player;

@end
