//
//  iTunesWebService.m
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "iTunesWebService.h"

@implementation iTunesWebService

#pragma mark - Get Info Methods

-(void)getInfoAboutAllAppsWithBlock:(void (^)(NSDictionary *))block forCompany:(NSString *)company
{
    iTunesWebServiceWorker *serviceWorker = [[iTunesWebServiceWorker alloc] init];
    [serviceWorker getResultDictionaryForAllApps:block forCompany:company];
}

@end
