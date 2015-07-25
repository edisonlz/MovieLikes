//
//  KMPhotoTimelineContributionsCell.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 04/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMGillSansLabel.h"
#import "KMMovie.h"

@interface KMMovieDetailsSimilarMoviesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *viewAllSimilarMoviesButton;

+ (KMMovieDetailsSimilarMoviesCell*) movieDetailsSimilarMoviesCell;

-(void) setupView:(KMMovie*) movieDetails context:(UIViewController *)context;
-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate;


@end
