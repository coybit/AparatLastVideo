//
//  VideoCollectionViewCell.h
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCollectionViewCell : UICollectionViewCell

@property BOOL compactMode;
@property (nonatomic,strong) UILabel* lblTitle;
@property (nonatomic,strong) UIImageView* imgViewPoster;

@end
