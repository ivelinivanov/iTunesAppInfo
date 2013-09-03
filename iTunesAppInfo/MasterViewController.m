//
//  MasterViewController.m
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    
    iTunesWebService *service = [[iTunesWebService alloc] init];
    
    [service getInfoAboutAllAppsWithBlock:^(NSDictionary *resultDictionary)
     {
         self.apps = [NSArray arrayWithArray:[resultDictionary valueForKey:kResultsKey]];
         [self.tableView reloadData];
     } forCompany:@"Mentormate"];
    
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.apps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *cellName = [self.apps[indexPath.row] valueForKey:kNameKey];
    
    cell.textLabel.text = cellName;
    
    NSString *iconURL = [self.apps[indexPath.row] objectForKey:kAppIconKey];
    
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: iconURL]];
    
    cell.imageView.image = [UIImage imageWithData:data];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        NSDictionary *appInfo = self.apps[indexPath.row];
        
        self.detailViewController.detailItem = appInfo;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *appInfo = self.apps[indexPath.row];
        
        [[segue destinationViewController] setDetailItem:appInfo];
    }
}

@end
