//
//  iTunesWebServiceWorker.h
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunesWebServiceConstants.h"

@interface iTunesWebServiceWorker : NSObject

@property (strong, nonatomic) NSMutableData *receivedData;
@property (copy, nonatomic) void (^block)(NSDictionary *);

-(void)connectToServerUsingURL:(NSString *) url;
-(void)getResultDictionaryForAllApps:(void (^)(NSDictionary *))block forCompany:(NSString *) company;

@end
