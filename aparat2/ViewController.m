//
//  ViewController.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "ViewController.h"
#import "Aparat.h"
#import <JMImageCache.h>
#import <UIImageView+JMImageCache.h>


@interface ViewController  ()
@end

@interface VideoCell : UICollectionViewCell
@end
@implementation VideoCell
@end

@implementation ViewController
{
    UICollectionView* collection;
    Aparat* aparat;
    NSArray* videosList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    videosList = [NSArray array];
    aparat = [[Aparat alloc] init];
    aparat.delegate = self;
    [aparat fetch];

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[VideoCell class] forCellWithReuseIdentifier:@"VideoCellID"];
    
    [self.view addSubview:collection];
    
    [self.view setBackgroundColor:[UIColor redColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    collection.frame = self.view.bounds;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return  CGSizeMake( self.view.frame.size.width , 100);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return  4;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
 
    return  4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return videosList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCellID" forIndexPath:indexPath];
    
    CGRect frame;
    VideoModel* video = (VideoModel*)videosList[indexPath.row];
    
    
    float width = self.view.frame.size.width;
    
    
    UIImage* img;
    UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(width-100, 0, 100, 100);
    imgView.tag = 1001;
    [cell.contentView addSubview:imgView];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width-100, 100)];
    lblTitle.text =  video.title;
    lblTitle.tag = 1002;
    lblTitle.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:lblTitle];
    
    [imgView setImageWithURL:[NSURL URLWithString:video.smallPoster] placeholder:nil];
    
    
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}


-(void)Aparat:(Aparat *)aparat withNewList:(NSArray *)videos {
    
    videosList = videos;
    [collection reloadData];
    
}

@end
