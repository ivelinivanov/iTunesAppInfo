//
//  MasterViewController.h
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTunesWebService.h"
#import "MasterViewControllerConstants.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *apps;

@end
