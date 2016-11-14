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
#import "VideoCollectionViewCell.h"
#import "CompactCollectionLayout.h"
#import "LargeCollectionLayout.h"


@interface ViewController  ()
@end


@implementation ViewController
{
    UICollectionView* collection;
    UIButton* btnChangeLayout;
    Aparat* aparat;
    NSArray* videosList;
    CompactCollectionLayout* compactLayout;
    LargeCollectionLayout* largeLayout;
    BOOL isCompact;
    UILabel* viewLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    videosList = [NSArray array];
    isCompact = YES;
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    
    // Creating a button
    btnChangeLayout = [[UIButton alloc] initWithFrame:CGRectZero];
    [btnChangeLayout setTitle:@"Layout" forState:UIControlStateNormal];
    [btnChangeLayout setTintColor:[UIColor blackColor]];
    [btnChangeLayout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangeLayout addTarget:self action:@selector(changeLayoutDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangeLayout];

    // Configuration of Collection View
    compactLayout = [[CompactCollectionLayout alloc] init];
    largeLayout = [[LargeCollectionLayout alloc] init];

    collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:compactLayout];
    collection.delegate = self;
    collection.dataSource = self;
    [collection setAutoresizingMask:
     UIViewAutoresizingFlexibleLeftMargin|
     UIViewAutoresizingFlexibleRightMargin|
     UIViewAutoresizingFlexibleTopMargin|
     UIViewAutoresizingFlexibleBottomMargin|
     UIViewAutoresizingFlexibleWidth|
     UIViewAutoresizingFlexibleHeight];
    collection.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [collection registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoCellID"];
    [self.view addSubview:collection];
    
    // Creating Loading View
    viewLoading = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
    viewLoading.center = self.view.center;
    viewLoading.text = @"Please Wait...";
    viewLoading.textColor = [UIColor whiteColor];
    viewLoading.textAlignment = NSTextAlignmentCenter;
    viewLoading.backgroundColor = [UIColor grayColor];
    viewLoading.layer.cornerRadius = 8;
    viewLoading.clipsToBounds = YES;
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    aparat = [[Aparat alloc] initWithDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    int topBar = 70;
    
    collection.frame = CGRectMake(0, topBar, width, height-topBar);
    btnChangeLayout.frame = CGRectMake(10, 16, 70, 30);
    
    [collection.collectionViewLayout invalidateLayout];
}


- (void)changeLayoutDidTouch:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
       
        [collection.collectionViewLayout invalidateLayout];
        [collection setCollectionViewLayout:isCompact?largeLayout:compactLayout animated:YES];
        
    }];
    
    isCompact = !isCompact;
}


#pragma mark CollectionView Delegate and Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return videosList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCellID" forIndexPath:indexPath];
    
    VideoModel* video = (VideoModel*)videosList[indexPath.row];
    cell.videoModel = video;
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}


#pragma mark Aparat Service Delegate

-(void)Aparat:(Aparat *)aparat withNewList:(NSArray *)videos {
    
    videosList = [videosList arrayByAddingObjectsFromArray:videos];
    [collection reloadData];
    
}

-(void)AparatWillFetchNewData:(Aparat *)aparat {
    viewLoading.alpha = 0;
    [self.view addSubview:viewLoading];

    [UIView animateWithDuration:0.1 animations:^{
        viewLoading.alpha = 1;
    }];
}

- (void)AparatDidFetchNewData:(Aparat *)aparat {
    [UIView animateWithDuration:0.1 animations:^{
        viewLoading.alpha = 0;
    }];
    [viewLoading removeFromSuperview];
}



#pragma mark ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if( scrollView.contentOffset.y > 0) // Just when scroll gets to the end of list
        [aparat fetchMoreLastVideos];
    
}


@end
