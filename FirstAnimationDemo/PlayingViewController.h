//
//  PlayingViewController.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSiriWaveformView.h"
#import "BackgroundPlayer.h"

@interface PlayingViewController : UIViewController<PlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@property (weak, nonatomic) IBOutlet UILabel *elapsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIImageView *loopIcon;
@property (weak, nonatomic) IBOutlet UIImageView *backwardIcon;
@property (weak, nonatomic) IBOutlet UIImageView *pauseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *forwardIcon;
@property (weak, nonatomic) IBOutlet UIButton *randomIcon;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *playInBarIcon;
@property (weak, nonatomic) IBOutlet UILabel *playInBarLabel;

@property (nonatomic, weak) IBOutlet SCSiriWaveformView *waveformView;

@end
