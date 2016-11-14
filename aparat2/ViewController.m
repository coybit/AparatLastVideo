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
#import <Reachability.h>

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
    UIAlertController* alertVC;
    BOOL isConnected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    videosList = [NSArray array];
    isCompact = YES;
    
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
    
    [self startCheckingNetworkConncetion];
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
    
    viewLoading.center = self.view.center;
    
    [collection.collectionViewLayout invalidateLayout];
}

- (void)startCheckingNetworkConncetion {
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.aparat.com"];
    
    reach.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            isConnected = YES;
            [self setupAparatService];
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            isConnected = NO;
            [self alertForNetworkDisconnecting];
        });
    };
    
    [reach startNotifier];
}


- (void)alertForNetworkDisconnecting {
    
    alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:@"No Internet connection!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* retryAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if( isConnected == NO )
            [self alertForNetworkDisconnecting];
        
    }];
    
    [alertVC addAction:retryAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupAparatService {
    videosList = [NSArray array];
    aparat = [[Aparat alloc] initWithDelegate:self];
    [collection reloadData];
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
    
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        //This condition will be true when scrollview will reach to bottom
        [aparat fetchMoreLastVideos];
    }
}


@end
