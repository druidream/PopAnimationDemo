//
//  SimpleCircularProgressView.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/22/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCircularProgressView : UIView

@property (strong, nonatomic)UIColor *centerColor;
@property (strong, nonatomic)UIColor *arcBackColor;
@property (strong, nonatomic)UIColor *arcFinishColor;
@property (strong, nonatomic)UIColor *arcUnfinishColor;

@property (assign, nonatomic)float percent;
@property (assign, nonatomic)float width;

@end
