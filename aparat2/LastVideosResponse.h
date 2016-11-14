//
//  LastVideosResponse.h
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "VideoModel.h"

@interface LastVideosResponse : JSONModel

@property (nonatomic) NSArray<VideoModel>* lastvideos;


@end
