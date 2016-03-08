//
//  ViewController.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/10/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SongTableViewController.h"
#import "PlayingViewController.h"
#import "SongTableViewCell.h"
#import "SongTableViewHeader.h"
#import "SongItem.h"
#import "SongStore.h"
#import "DDGradiantView.h"
#import "BackgroundImageProcessor.h"

#import <pop/POP.h>
#import "GPUImageiOSBlurFilter.h"
#import "GPUImageRGBFilter.h"

@interface SongTableViewController ()

@end

@implementation SongTableViewController
@synthesize tableView = _tableView;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // background view
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
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
    UINib *nib = [UINib nibWithNibName:@"SongTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SongTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];

    [self _animateInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // register delegate to update progress view
    [[BackgroundPlayer sharedInstance] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170.0;
    } else {
        return 78.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *store = [SongStore sharedStore];
    
    if (indexPath.row == 0) {
        return [[SongTableViewHeader alloc] init];
    } else {
        static NSString *TableSampleIdentifier = @"SongTableViewCell";
        SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier  forIndexPath:indexPath];
        
        if(indexPath.row % 2 ){
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            UIColor *backgroundColor = [UIColor colorWithRed:(246.0/255.0) green:(246.0/255) blue:(249.0/255) alpha:1.0];
            cell.backgroundColor = backgroundColor;
        }

        SongItem *songItem = [store objectAtIndex:indexPath.row-1];
        cell.titleLabel.text = songItem.title;
        cell.artistLabel.text = songItem.artist;
        cell.votesLabel.text = [NSString stringWithFormat:@"%d votes", (int)songItem.votes];
        cell.idLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        PlayingViewController *playingViewController = [[PlayingViewController alloc] init];
        [self.navigationController pushViewController:playingViewController animated:NO];
    }
}

- (void)currentTime:(NSTimeInterval)time withDuration:(NSTimeInterval)duration
{
    SongTableViewCell *cell;
    for (SongTableViewCell *item in [self.tableView visibleCells]) {
        if ([item isSelected]) {
            cell = item;
            break;
        }
    }
    
    if ([cell respondsToSelector:@selector(progressView)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.progressView.percent = time / duration;
        });
    }
}

#pragma mark - Private
- (UIView *)_blurredBackground
{
    UIImage *image = [UIImage imageNamed:@"sample.jpg"];
    GPUImageRGBFilter *f = [[GPUImageRGBFilter alloc]init];
    f.red = 0.6;
    f.green = 0.6;
    f.blue = 0.8;
    UIImage *filteredImg = [f imageByFilteringImage:image];
    GPUImageiOSBlurFilter * blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 1.0;
    blurFilter.downsampling = 16.0;
    UIImage *blurredImage = [blurFilter imageByFilteringImage:filteredImg];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:blurredImage];
    [bgView setContentMode:UIViewContentModeScaleAspectFill];
    [bgView setClipsToBounds:YES];
    DDGradiantView *view = [[DDGradiantView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor clearColor];
    [bgView addSubview:view];
    return bgView;
}

- (void)_animateInterface
{
    NSArray *visibleCells = self.tableView.visibleCells;
    for (int i=0; i<visibleCells.count; i++) {
        SongTableViewCell *cell = [visibleCells objectAtIndex:i];
        [cell setHidden:YES];
        double delayInSeconds = i * 0.06;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [cell setHidden:NO];
            
            POPSpringAnimation *animation = [POPSpringAnimation animation];
            animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationX];
            animation.fromValue = @(300.0);
            animation.toValue = @0.0;
            animation.springBounciness = 15.0;
            animation.springSpeed = 5;

            
            [cell.layer pop_addAnimation:animation forKey:nil];
        });
    }
}

@end
