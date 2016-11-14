//
//  Aparat.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "Aparat.h"
#import "ResponseModels.h"

@implementation Aparat
{
    NSMutableArray* lastFetchVideos;
    NSString* apiLastVideo;
    NSString* nextPageLink;
}

- (instancetype)initWithDelegate:(id<AparatDelegate>)delegate {
    
    self = [super init];
    
    if( self ){
        
        apiLastVideo = @"http://www.aparat.com/etc/api/lastvideos";
        
        self.delegate = delegate;
        [self fetchLastVideosForFirstTime];
    }
    
    return  self;
}

- (void)fetchLastVideosForFirstTime {
    [self fetchLastVideosOnURL:apiLastVideo];
}

- (void)fetchMoreLastVideos {
    [self fetchLastVideosOnURL:nextPageLink];
}

- (void)fetchLastVideosOnURL:(NSString*)strURL {
    
    [self.delegate AparatWillFetchNewData:self];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    NSLog(strURL);
    
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Mapping the reponse
        NSString* json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        LastVideosResponse* res = [[LastVideosResponse alloc] initWithString:json error:nil];

        nextPageLink = res.ui.pagingForward;

        // Notifying about new data
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.delegate AparatDidFetchNewData:self];
            [self.delegate Aparat:self withNewList:res.lastvideos];
            
        });
        
    }];
    
    [getDataTask resume];
    
}

@end
