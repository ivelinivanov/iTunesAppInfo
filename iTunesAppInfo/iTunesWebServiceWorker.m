//
//  iTunesWebServiceWorker.m
//  iTunesAppInfo
//
//  Created by Ivelin Ivanov on 7/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "iTunesWebServiceWorker.h"

@implementation iTunesWebServiceWorker

-(id)init
{
    if(self = [super init])
    {
        self.receivedData = [NSMutableData data];
        return self;
    }
    else
    {
        return nil;
    }
}

#pragma mark - Get Results Methods

-(void)getResultDictionaryForAllApps:(void (^)(NSDictionary *))block forCompany:(NSString *)company
{
    self.block = block;
    NSString *url = [[NSString alloc] initWithFormat:kAllAppsQueryURL, company];
    
    [self connectToServerUsingURL:url];
}

#pragma mark - Connection Methods

-(void)connectToServerUsingURL:(NSString *)url
{
    NSString* s = [[NSString alloc] initWithFormat:url];
    NSURL* urlPath = [NSURL URLWithString:s];
    NSURLRequest* req = [NSURLRequest requestWithURL:urlPath];
    NSURLConnection* conn = [NSURLConnection connectionWithRequest:req delegate:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Something went wrong with retreiving data about apps." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    
    NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];
    
    self.block(resultDict);
}

@end
