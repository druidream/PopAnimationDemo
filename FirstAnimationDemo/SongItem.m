//
//  SongItem.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SongItem.h"

@implementation SongItem

@synthesize title=_title, artist=_artist, votes=_votes;

-(id)initWithTitle:(NSString *)title artist:(NSString*)artist votes:(NSInteger)votes{
    self = [super init];
    if (self) {
        self.title = title;
        self.artist = artist;
        self.votes = votes;
    }
    return self;
}

@end
