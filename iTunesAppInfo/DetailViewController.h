//
//  DetailViewController.h
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewControllerConstants.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) NSMutableArray *images;



@end
