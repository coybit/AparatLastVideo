//
//  Aparat.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "Aparat.h"
#import "LastVideosResponse.h"

@implementation Aparat
{
    NSMutableArray* lastFetchVideos;
    NSString* apiLastVideo;
}

- (instancetype)initWithDelegate:(id<AparatDelegate>)delegate {
    
    self = [super init];
    
    if( self ){
        
        apiLastVideo = @"http://www.aparat.com/etc/api/lastvideos";
        
        self.delegate = delegate;
        [self fetchLastVideos];
    }
    
    return  self;
}

- (void)fetchLastVideos {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:apiLastVideo];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];

    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Mapping the reponse
        NSString* json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        LastVideosResponse* res = [[LastVideosResponse alloc] initWithString:json error:nil];

        // Notifying about new data
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.delegate Aparat:self withNewList:res.lastvideos];
            
        });
        
    }];
    
    [postDataTask resume];
    
}


@end
