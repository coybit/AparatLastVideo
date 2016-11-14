//
//  Aparat.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "Aparat.h"

@implementation Aparat
{
    NSMutableArray* lastFetchVideos;
}

- (void)fetchLastVides {
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://www.aparat.com/etc/api/lastvideos"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    //[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"GET"];
    //NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"TEST IOS", @"name",
                             //@"IOS TYPE", @"typemap",
                             //nil];
    //NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    //[request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError* err;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        
        NSArray* videos = result[@"lastvideos"];
        
        lastFetchVideos = [[NSMutableArray alloc] init];
        
        for (NSDictionary* video in videos) {
            
            VideoModel* vmodel = [[VideoModel alloc] init];
            vmodel.title = video[@"title"];
            vmodel.bigPoster = video[@"big_poster"];
            vmodel.smallPoster = video[@"small_poster"];
            [lastFetchVideos addObject:vmodel];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.delegate Aparat:self withNewList:lastFetchVideos];
            
        });
        
    }];
    
    [postDataTask resume];
    
}

- (void)fetch {
    
    [self fetchLastVides];
    
}

@end
