//
//  SongItem.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/14/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *artist;
@property (assign, nonatomic) NSInteger *votes;

-(id)initWithTitle:(NSString *)title artist:(NSString*)artist votes:(NSInteger)votes;

@end
