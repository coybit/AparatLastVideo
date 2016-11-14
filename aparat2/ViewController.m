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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    videosList = [NSArray array];
    aparat = [[Aparat alloc] init];
    aparat.delegate = self;
    [aparat fetch];

    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    
    btnChangeLayout = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    [btnChangeLayout setTitle:@"Layout" forState:UIControlStateNormal];
    [btnChangeLayout setTintColor:[UIColor blackColor]];
    [btnChangeLayout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangeLayout addTarget:self action:@selector(changeLayoutDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangeLayout];

    // Configuration of Collection View
    compactLayout = [[CompactCollectionLayout alloc] init];
    largeLayout = [[LargeCollectionLayout alloc] init];

    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 16, width, height-16) collectionViewLayout:compactLayout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [collection registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoCellID"];
    [self.view addSubview:collection];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    int topBar = 60;
    
    collection.frame = CGRectMake(0, topBar, width, height-topBar);
    btnChangeLayout.frame = CGRectMake(10, 20, 70, 30);
}

BOOL isCompact = YES;

- (void)changeLayoutDidTouch:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
       
        [collection.collectionViewLayout invalidateLayout];
        [collection setCollectionViewLayout:isCompact?largeLayout:compactLayout animated:YES];
        
    }];
    
    isCompact = !isCompact;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return videosList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCellID" forIndexPath:indexPath];
    
    VideoModel* video = (VideoModel*)videosList[indexPath.row];

    cell.lblTitle.text = video.title;
    [cell.imgViewPoster setImageWithURL:[NSURL URLWithString:video.smallPoster] placeholder:nil];
    cell.compactMode = isCompact;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

-(void)Aparat:(Aparat *)aparat withNewList:(NSArray *)videos {
    
    videosList = videos;
    [collection reloadData];
    
}

@end
