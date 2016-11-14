//
//  CompactCollectionLayout.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "CompactCollectionLayout.h"

@implementation CompactCollectionLayout
{
    CGFloat itemHeight;
    NSMutableArray* attributes;
}

-(instancetype)init {
    self = [super init];
    [self setupLayout];
    
    return self;
}

/**
 Init method
 
 - parameter aDecoder: aDecoder
 
 - returns: self
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupLayout];
    
    return  self;
}

- (void)prepareLayout {
    [super prepareLayout];
}

/**
 Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
 */
- (void)setupLayout {
    itemHeight = 100;
    self.minimumInteritemSpacing =
    self.minimumLineSpacing = 5;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (CGFloat)itemWidth {
    return CGRectGetWidth(self.collectionView.frame) - 20;
}

- (CGSize)itemSize {
    return CGSizeMake([self itemWidth], itemHeight);
}

- (void)setItemSize:(CGSize)itemSize {
    self.itemSize = CGSizeMake([self itemWidth], itemHeight);
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    return self.collectionView.contentOffset;
}


@end
