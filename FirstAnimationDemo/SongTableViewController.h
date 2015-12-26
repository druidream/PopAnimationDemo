//
//  SongTableViewController.h
//  FirstAnimationDemo
//
//  Created by Gu Jun on 12/21/15.
//  Copyright (c) 2015 dream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundPlayer.h"

@interface SongTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, PlayerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
