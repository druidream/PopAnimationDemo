//
//  SongTableViewHeader.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SongTableViewHeader.h"

@implementation SongTableViewHeader

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = frame.size.width;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, width, 20)];
        [label1 setBackgroundColor:[UIColor clearColor]];
        NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:@"DANCE CLUB" attributes:@{NSKernAttributeName : @(2.0f)}];
        [label1 setAttributedText:attributedString];
        [label1 setTextColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [label1 setFont:[UIFont fontWithName:@"Avenir-Black" size:12.0]];
        [label1 setShadowColor:[UIColor whiteColor]];
        [label1 setShadowOffset:CGSizeMake(0, 0)];
        [self.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, width, 50)];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [label2 setText:@"Ministry of Fun"];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [label2 setTextColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
        UIFont *font = [UIFont fontWithName:@"Helvetica-Light" size:28.0];
        [label2 setShadowColor:[UIColor whiteColor]];
        [label2 setShadowOffset:CGSizeMake(0, 0)];
        [label2 setFont:font];
        [self.contentView addSubview:label2];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, width - 30*2, 40)];
        attributedString =[[NSAttributedString alloc] initWithString:@"ADD A SONG" attributes:@{NSKernAttributeName : @(2.0f)}];
        [button1 setAttributedTitle:attributedString forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        button1.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        [button1.layer setBorderColor:[[UIColor colorWithWhite:1.0 alpha:0.4]CGColor]];
        [button1.layer setMasksToBounds:YES];
        [button1.layer setCornerRadius:20.0];
        [button1.layer setBorderWidth:1.0];
        [self.contentView addSubview:button1];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
