//
//  SongStore.m
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import "SongStore.h"
#import "SongItem.h"

@implementation SongStore

+(NSMutableArray *)sharedStore{
    NSMutableArray *store = [[NSMutableArray alloc]init];
    [store addObject:[[SongItem alloc] initWithTitle:@"Teenage Dream" artist:@"Katty Perry" votes:23]];
    [store addObject:[[SongItem alloc] initWithTitle:@"I remember to forget" artist:@"Shakira" votes:19]];
    [store addObject:[[SongItem alloc] initWithTitle:@"Timber" artist:@"Pitbull" votes:10]];
    [store addObject:[[SongItem alloc] initWithTitle:@"Video Games" artist:@"Lana De Ray" votes:3]];
    [store addObject:[[SongItem alloc] initWithTitle:@"V piaotok podvečer" artist:@"HEX" votes:2]];
    [store addObject:[[SongItem alloc] initWithTitle:@"new song" artist:@"new band" votes:0]];
    return store;
}

@end
