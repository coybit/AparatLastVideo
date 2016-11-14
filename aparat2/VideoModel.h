//
//  VideoModel.h
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@protocol VideoModel;

@interface VideoModel : JSONModel

@property (nonatomic) NSString* title;
@property (nonatomic) NSString* big_poster;
@property (nonatomic) NSString* small_poster;

@end
