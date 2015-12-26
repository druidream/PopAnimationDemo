//
//  SongTableViewHeader.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SongTableViewHeader.h"
#import "FXLabel.h"

@implementation SongTableViewHeader

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 20)];
        [lable1 setBackgroundColor:[UIColor clearColor]];
        NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:@"DANCE CLUB" attributes:@{NSKernAttributeName : @(2.0f)}];
        [lable1 setAttributedText:attributedString];
        [lable1 setTextColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
        [lable1 setTextAlignment:NSTextAlignmentCenter];
        [lable1 setFont:[UIFont fontWithName:@"Avenir-Black" size:12.0]];
        [lable1 setShadowColor:[UIColor whiteColor]];
        [lable1 setShadowOffset:CGSizeMake(0, 0)];
        //lable1.shadowBlur = 0.5f;
        [self.contentView addSubview:lable1];
        
        FXLabel *lable2 = [[FXLabel alloc] initWithFrame:CGRectMake(0, 40, 320, 50)];
        [lable2 setBackgroundColor:[UIColor clearColor]];
        [lable2 setText:@"Ministry of Fun"];
        [lable2 setTextAlignment:NSTextAlignmentCenter];
        [lable2 setTextColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
        UIFont *font = [UIFont fontWithName:@"Helvetica-Light" size:28.0];
        [lable2 setShadowColor:[UIColor whiteColor]];
        [lable2 setShadowOffset:CGSizeMake(0, 0)];
        lable2.shadowBlur = 0.5f;
        [lable2 setFont:font];
        [self.contentView addSubview:lable2];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 260, 40)];
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
