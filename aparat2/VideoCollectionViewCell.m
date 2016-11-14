//
//  VideoCollectionViewCell.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "VideoCollectionViewCell.h"
#import <JMImageCache.h>
#import <UIImageView+JMImageCache.h>

@implementation VideoCollectionViewCell
{
    NeatLabel* lblTitle;
    UIImageView* imgViewPoster;
    VideoModel* mVideoModel;
    BOOL isCompact;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if( self ) {
        
        imgViewPoster = [[UIImageView alloc] initWithFrame:CGRectZero];
        imgViewPoster.contentMode = UIViewContentModeScaleAspectFill;
        imgViewPoster.clipsToBounds = YES;
        [self.contentView addSubview:imgViewPoster];
        
        lblTitle = [[NeatLabel alloc] initWithFrame:CGRectZero];
        lblTitle.numberOfLines = 0;
        lblTitle.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lblTitle];
        
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    }
    
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
 
    float cellWidth = self.frame.size.width;
    float cellHeight = self.frame.size.height;
    
    CGSize imageSize;
    CGSize labelSize;
    
    if( layoutAttributes.frame.size.height == 100 ) // isCompact
    {
        isCompact = YES;
        
        imageSize = CGSizeMake(100, cellHeight);
        labelSize = CGSizeMake(cellWidth-100, cellHeight);
        
        lblTitle.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
        imgViewPoster.frame = CGRectMake(cellWidth-imageSize.width, 0, imageSize.width, imageSize.height);
        
    }
    else{ // is Large mode
        
        isCompact = NO;
        
        imageSize = CGSizeMake(cellWidth, 0.75 * cellHeight);
        labelSize = CGSizeMake(cellWidth, 0.25 * cellHeight);
        
        imgViewPoster.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        lblTitle.frame = CGRectMake(0, imageSize.height, labelSize.width, labelSize.height);
    }
    
    [self fillWithVideoModel];
}

- (void)setVideoModel:(VideoModel *)videoModel {
    
    mVideoModel = videoModel;
    [self fillWithVideoModel];
    
}

- (VideoModel*)videoModel {
    return mVideoModel;
}


- (void)fillWithVideoModel {
    
    lblTitle.text = mVideoModel.title;
    
    if( isCompact ) {
        [imgViewPoster setImageWithURL:[NSURL URLWithString:mVideoModel.small_poster] placeholder:nil];
    }
    else {
        [imgViewPoster setImageWithURL:[NSURL URLWithString:mVideoModel.big_poster] placeholder:nil];
    }
    
}

@end
