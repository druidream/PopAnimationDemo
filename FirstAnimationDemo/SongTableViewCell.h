//
//  SongTableViewCell.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/11/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleCircularProgressView.h"
#import "SimpleWaveHistogramView.h"

@interface SongTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet SimpleCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet SimpleWaveHistogramView *histogramView;

- (void)showProgressView;
- (void)hideProgressView;

@end
