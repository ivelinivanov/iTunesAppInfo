//
//  iTunesWebService.h
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunesWebServiceWorker.h"

@interface iTunesWebService : NSObject

-(void)getInfoAboutAllAppsWithBlock:(void (^)(NSDictionary *))block forCompany:(NSString *)company;

@end
