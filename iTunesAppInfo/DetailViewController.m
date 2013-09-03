//
//  DetailViewController.m
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation DetailViewController



#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
      
        [self configureView];
    }

    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    if (self.detailItem)
    {
        
        self.contentScrollView.frame = self.view.frame;
        
        CGRect imageScrollFrame = self.imageScrollView.frame;
        imageScrollFrame.size.width = self.view.frame.size.width - kBorderOffset;
        imageScrollFrame.origin.x = kImageScrollOriginX;
        imageScrollFrame.origin.y = kImageScrollOriginY;
        self.imageScrollView.frame = imageScrollFrame;
        
        CGRect nameFrame = self.nameLabel.frame;
        nameFrame.size.width = self.view.frame.size.width;
        nameFrame.origin.x = kNameLabelOriginX;
        nameFrame.origin.y = kNameLabelOriginY;
        self.nameLabel.frame = nameFrame;
        
        self.nameLabel.text = [self.detailItem objectForKey:kNameKey];
        
        self.imageScrollView.contentSize = CGSizeMake([[self.detailItem objectForKey:kScreenshotsKey] count] * (kImageWidth + 10), kImageHeight);
        
        int counter = 0;
        
        for (int i = 0; i < [self.images count]; i++)
        {
            [self.images[i] removeFromSuperview];
        }
        
        [self.images removeAllObjects];
        
        for(NSString *screenshotURL in [self.detailItem objectForKey:kScreenshotsKey])
        {
            CGFloat xOrigin = counter * (kImageWidth + 20);
            counter++;
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: screenshotURL]];
         
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, kImageWidth, kImageHeight)];
            imageView.image = [UIImage imageWithData: data];
            [self.images addObject:imageView];
            
            [self.imageScrollView addSubview:imageView];
        }
        
        if(self.descriptionLabel)
            [self.descriptionLabel removeFromSuperview];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDescriptionLabelXOrigin, kDescriptionLabelYOrigin, self.view.frame.size.width, 30)];
        
        NSString *descText = [self.detailItem objectForKey:kDescriptionKey];
        self.descriptionLabel.text = descText;
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        CGSize expectedLabelSize = [descText sizeWithFont:self.descriptionLabel.font constrainedToSize:maximumLabelSize lineBreakMode:self.descriptionLabel.lineBreakMode];
        
        //adjust the label the the new height.
        CGRect newFrame = self.descriptionLabel.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.size.width = self.view.frame.size.width - kBorderOffset * 2;
        self.descriptionLabel.frame = newFrame;
               
        self.descriptionLabel.numberOfLines = 0;
        [self.descriptionLabel sizeToFit];
        
        [self.contentScrollView addSubview:self.descriptionLabel];
        self.contentScrollView.delegate = self;
        
        self.contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, kDescriptionLabelYOrigin + self.descriptionLabel.frame.size.height + kStatusBarHeight);
        [self.contentScrollView setScrollEnabled:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}

- (void) orientationDidChange: (NSNotification *) note
{
    [self configureView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.contentScrollView.frame = self.view.frame;
    self.images = [[NSMutableArray alloc] init];
    [self configureView];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationDidChange:)  name:UIDeviceOrientationDidChangeNotification  object:nil];
    
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Apps", @"Apps");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
