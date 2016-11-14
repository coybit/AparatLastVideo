//
//  VideoCollectionViewCell.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@implementation VideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if( self ) {
        
        self.imgViewPoster = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imgViewPoster.contentMode = UIViewContentModeScaleAspectFill;
        self.imgViewPoster.clipsToBounds = YES;
        [self.contentView addSubview:self.imgViewPoster];
        
        self.lblTitle = [[NeatLabel alloc] initWithFrame:CGRectZero];
        self.lblTitle.numberOfLines = 0;
        self.lblTitle.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.lblTitle];
        
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
        imageSize = CGSizeMake(100, cellHeight);
        labelSize = CGSizeMake(cellWidth-100, cellHeight);
        
        self.lblTitle.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
        self.imgViewPoster.frame = CGRectMake(cellWidth-imageSize.width, 0, imageSize.width, imageSize.height);
        
    }
    else{ // is Large mode
        imageSize = CGSizeMake(cellWidth, 0.75 * cellHeight);
        labelSize = CGSizeMake(cellWidth, 0.25 * cellHeight);
        
        self.imgViewPoster.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        self.lblTitle.frame = CGRectMake(0, imageSize.height, labelSize.width, labelSize.height);
    }
    
}


@end
