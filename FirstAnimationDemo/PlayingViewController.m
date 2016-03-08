//
//  PlayingViewController.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "PlayingViewController.h"
#import "BackgroundPlayer.h"
#import "BackgroundImageProcessor.h"
#import "DDGradiantView.h"

#import <pop/POP.h>
#import "GPUImageiOSBlurFilter.h"
#import "GPUImageRGBFilter.h"
#import "GPUImageVignetteFilter.h"

@interface PlayingViewController ()


@end

@implementation PlayingViewController
@synthesize bgImage,coverImage, titleLabel, artistLabel, elapsedLabel, totalLabel;
@synthesize progressView, loopIcon, backwardIcon, pauseIcon, forwardIcon, randomIcon;
@synthesize bottomView, playInBarIcon;
@synthesize waveformView;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // navigation bar
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *barButtonItemLeft = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(navBack)];
    UIImage *img = [UIImage imageNamed:@"navback"];
    [barButtonItemLeft setImage:img];
    [[self navigationItem] setLeftBarButtonItem:barButtonItemLeft];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    img = [UIImage imageNamed:@"heart"];
    addButton.image = img;
    
    UIBarButtonItem *likeButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    img = [UIImage imageNamed:@"add"];
    likeButton.image = img;

    NSArray *rightButtons = [NSArray arrayWithObjects:likeButton, addButton, nil];
    [[self navigationItem] setRightBarButtonItems:rightButtons];
    
    // main screen
    self.titleLabel.text = @"Video Games";
    self.artistLabel.text = @"Lana De Ray";
    self.elapsedLabel.text = nil;
    self.totalLabel.text = nil;
    
    // background image
    UIImage *bgImg = [[BackgroundImageProcessor sharedInstance] bg];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:bgImg];
    [backgroundImageView setFrame:self.view.bounds];
    [backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImageView setClipsToBounds:YES];
    DDGradiantView *view = [[DDGradiantView alloc] initWithFrame:self.view.bounds];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor clearColor];
    [backgroundImageView addSubview:view];
    
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    backgroundImageView.layer.zPosition = -10000;
    
    // animation
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    coverImage.superview.layer.sublayerTransform = rotationAndPerspectiveTransform;
    
    progressView.progress = 0.3;
    progressView.trackTintColor = [UIColor colorWithWhite:1 alpha:0.3];
    progressView.tintColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    UIImage *mask = [UIImage imageNamed:@"pause-mask"];
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, 40, 40);
    maskLayer.contents = (id)[mask CGImage];
    [pauseIcon.layer setMask:maskLayer];
    
    
    UIImage *playMask = [UIImage imageNamed:@"play-mask"];
    CALayer* playMaskLayer = [CALayer layer];
    playMaskLayer.frame = CGRectMake(0, 0, 40, 40);
    playMaskLayer.contents = (id)[playMask CGImage];
    [playInBarIcon.layer setMask:playMaskLayer];
    
    //player
    if (![[BackgroundPlayer sharedInstance] isPlaying]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[BackgroundPlayer sharedInstance] play];
        });
    }
    
    // waveform view
    CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMeters)];
    [displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [self.view sendSubviewToBack:self.waveformView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
        [self.waveformView setWaveColor:[UIColor whiteColor]];
        [self.waveformView setPrimaryWaveLineWidth:2.0f];
        [self.waveformView setSecondaryWaveLineWidth:0.5];
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    loopIcon.layer.opacity = 0;
    backwardIcon.layer.opacity = 0;
    pauseIcon.layer.opacity = 0;
    forwardIcon.layer.opacity = 0;
    randomIcon.layer.opacity = 0;

    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerRotationY];
    animation.fromValue = @(M_PI/3);
    animation.toValue = @0.0;
    animation.springBounciness = 24.0;
    animation.springSpeed = 30;
    [coverImage.layer setAnchorPoint:CGPointMake(0, 0.5)];
    CGPoint positionOld = coverImage.layer.position;
    CGPoint positionNew = CGPointMake(0, 0);
    positionNew.x = positionOld.x + (0 - 0.5)  * 200;
    positionNew.y = positionOld.y;
    [coverImage.layer setPosition:positionNew];
    [coverImage.layer pop_addAnimation:animation forKey:nil];
    
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationX];
    animation.fromValue = @(-200.0);
    animation.toValue = @0.0;
    animation.springBounciness = 1.0;
    animation.springSpeed = 5;
    animation.beginTime = CACurrentMediaTime() + 0.1;
    [titleLabel.layer pop_addAnimation:animation forKey:nil];
    
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationX];
    animation.fromValue = @(-200.0);
    animation.toValue = @0.0;
    animation.springBounciness = 1.0;
    animation.springSpeed = 5;
    animation.beginTime = CACurrentMediaTime() + 0.2;
    [artistLabel.layer pop_addAnimation:animation forKey:nil];
    
    // bottom
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationY];
    animation.fromValue = @(100.0);
    animation.toValue = @0.0;
    animation.springBounciness = 5.0;
    animation.springSpeed = 1;
    animation.beginTime = CACurrentMediaTime();
    [bottomView.layer pop_addAnimation:animation forKey:nil];
    
    float latencyUnit = 0.06;
    float a = 0.3;
    NSNumber *fromValue = @(80.0);
    float springBounciness = 0.3;
    float springSpeed = 0.8;
    
    // player buttons
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationY];
    animation.fromValue = fromValue;
    animation.toValue = @0.0;
    animation.springBounciness = springBounciness;
    animation.springSpeed = springSpeed;
    animation.beginTime = CACurrentMediaTime() + a +latencyUnit * 1;
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animation];
    opacityAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    opacityAnimation.fromValue = @0;
    opacityAnimation.toValue = @0.8;
    opacityAnimation.beginTime = CACurrentMediaTime() + a +latencyUnit * 1;
    [loopIcon.layer pop_addAnimation:animation forKey:nil];
    [loopIcon.layer pop_addAnimation:opacityAnimation forKey:nil];
    
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationY];
    animation.fromValue = fromValue;
    animation.toValue = @0.0;
    animation.springBounciness = springBounciness;
    animation.springSpeed = springSpeed;
    animation.beginTime = CACurrentMediaTime() + a +latencyUnit * 2;
    [backwardIcon.layer pop_addAnimation:animation forKey:nil];
    opacityAnimation.beginTime = CACurrentMediaTime() + a +latencyUnit * 2;
    [backwardIcon.layer pop_addAnimation:opacityAnimation forKey:nil];
    
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationY];
    animation.fromValue = fromValue;
    animation.toValue = @0.0;
    animation.springBounciness = springBounciness;
    animation.springSpeed = springSpeed;
    animation.beginTime = CACurrentMediaTime() + a +latencyUnit * 3;
    [pauseIcon.layer pop_addAnimation:animation forKey:nil];
    opacityAnimation.beginTime = CACurrentMediaTime() + a +latencyUnit * 3;
    [pauseIcon.layer pop_addAnimation:opacityAnimation forKey:nil];
    
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationY];
    animation.fromValue = fromValue;
    animation.toValue = @0.0;
    animation.springBounciness = springBounciness;
    animation.springSpeed = springSpeed;
    animation.beginTime = CACurrentMediaTime() + a +latencyUnit * 4;
    [forwardIcon.layer pop_addAnimation:animation forKey:nil];
    opacityAnimation.beginTime = CACurrentMediaTime() + a +latencyUnit * 4;
    [forwardIcon.layer pop_addAnimation:opacityAnimation forKey:nil];
    
    animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationY];
    animation.fromValue = fromValue;
    animation.toValue = @0.0;
    animation.springBounciness = springBounciness;
    animation.springSpeed = springSpeed;
    animation.beginTime = CACurrentMediaTime() + a +latencyUnit * 5;
    [randomIcon.layer pop_addAnimation:animation forKey:nil];
    opacityAnimation.beginTime = CACurrentMediaTime() + a +latencyUnit * 5;
    [randomIcon.layer pop_addAnimation:opacityAnimation forKey:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[BackgroundPlayer sharedInstance] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)currentTime:(NSTimeInterval)currentTime withDuration:(NSTimeInterval)duration
{
    dispatch_async(dispatch_get_main_queue(), ^{
        progressView.progress = currentTime / duration;
        [progressView setNeedsDisplay];
        
        // update text
        NSString *currentTimeString = [NSString stringWithFormat:@"%2li:%02li",
                                       lround(floor(currentTime / 60.)) % 60,
                                       lround(floor(currentTime)) % 60];
        if (![currentTimeString isEqualToString:elapsedLabel.text]) {
            [elapsedLabel setText:currentTimeString];
        }
        
        if (!totalLabel.text) {
            NSString *durationString = [NSString stringWithFormat:@"%2li:%02li",
                                        lround(floor(duration / 60.)) % 60,
                                        lround(floor(duration)) % 60];
            [totalLabel setText:durationString];
        }
    });
}

#pragma mark - Private
- (void)updateMeters
{
    BackgroundPlayer *player = [BackgroundPlayer sharedInstance];

    [self.waveformView updateWithLevel:[player normalizedPowerLevel]];
}

- (void)navBack
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
