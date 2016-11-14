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
        
        float width = frame.size.width;

        self.compactMode = YES;
        
        self.imgViewPoster = [[UIImageView alloc] initWithFrame:CGRectMake(width-100, 0, 100, 100)];
        [self.contentView addSubview:self.imgViewPoster];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width-100, 100)];
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
 
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    if( layoutAttributes.frame.size.height == 100 )
    {
        self.imgViewPoster.frame = CGRectMake(width-100, 0, 100, 100);
        self.lblTitle.frame = CGRectMake(0, 0, width-100, 100);
    }
    else{
        self.imgViewPoster.frame = CGRectMake(0, 0, width, height/2);
        self.lblTitle.frame = CGRectMake(0, height/2, width, height/2);
    }
    
}


@end
