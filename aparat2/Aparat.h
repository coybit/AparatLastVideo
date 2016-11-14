//
//  Aparat.h
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"

@class Aparat;

@protocol AparatDelegate <NSObject>
- (void)AparatWillFetchNewData:(Aparat*)aparat;
- (void)AparatDidFetchNewData:(Aparat*)aparat;
- (void)Aparat:(Aparat*)aparat withNewList:(NSArray*)videos;
@end

@interface Aparat : NSObject <NSURLSessionTaskDelegate>

@property (weak,nonatomic) id<AparatDelegate> delegate;

- (instancetype)initWithDelegate:(id<AparatDelegate>)delegate;
- (void)fetchMoreLastVideos;

@end
