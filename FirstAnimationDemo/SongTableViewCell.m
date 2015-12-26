//
//  SongTableViewCell.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/11/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SongTableViewCell.h"
#import "GPUImageMonochromeFilter.h"
#import "GPUImageContrastFilter.h"
#import "GPUImageRGBFilter.h"
#import "GPUImageSepiaFilter.h"
#import "GPUImageSolidColorGenerator.h"

@implementation SongTableViewCell
@synthesize idLabel, titleLabel, artistLabel, votesLabel;
@synthesize progressView, histogramView;

// NOT USED
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [progressView setHidden:YES];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self showProgressView];

        // TODO: dis-blurred background view
        
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor colorWithRed:255/255.0 green:224/255.0 blue:160/255.0 alpha:0.9];
        self.backgroundView = bg;
    } else {
        [self hideProgressView];
        self.backgroundView = nil;
    }
}

- (void)showProgressView
{
    [progressView setHidden:NO];
    progressView.centerColor = [UIColor colorWithRed:255/255.0 green:224/255.0 blue:160/255.0 alpha:1];
    progressView.arcFinishColor = [UIColor redColor];
    progressView.arcUnfinishColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    progressView.arcBackColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    progressView.width = 1.2;
    
    [self.histogramView startAnimating];
}

- (void)hideProgressView
{
    [progressView setHidden:YES];
    [histogramView stopAnimating];
}

@end
