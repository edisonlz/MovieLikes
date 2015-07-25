//
//  KMPhotoTimelineContributionsCell.m
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 04/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import "KMMovieDetailsSimilarMoviesCell.h"
#import "KMSimilarMoviesCollectionViewCell.h"
#import "KMSimilarMoviesSource.h"
#import "DetailViewController.h"

@interface KMMovieDetailsSimilarMoviesCell () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray* similarMoviesDataSource;
@property (nonatomic,strong) UIViewController * context;
@end


@implementation KMMovieDetailsSimilarMoviesCell

#pragma mark -
#pragma mark Cell Init Methods

+ (KMMovieDetailsSimilarMoviesCell*) movieDetailsSimilarMoviesCell
{
    KMMovieDetailsSimilarMoviesCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"KMMovieDetailsSimilarMoviesCell" owner:self options:nil] objectAtIndex:0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

#pragma mark -
#pragma mark CollectionView Datasource Setup

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate {
    
    [self.collectionView registerClass:[KMSimilarMoviesCollectionViewCell class] forCellWithReuseIdentifier:@"KMSimilarMoviesCollectionViewCell"];
    
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    
    [self.collectionView reloadData];
}

-(void) setupView:(KMMovie*) movieDetails context:(UIViewController *)context {
    
    _context = context;
    [self requestSimilarMovies:movieDetails];
}

#pragma mark -
#pragma mark Network request
- (void)requestSimilarMovies:(KMMovie*) movieDetails
{
    KMSimilarMoviesCompletionBlock completionBlock = ^(NSArray* data, NSString* errorString)
    {
        [self processSimilarMoviesData:data];
    };
    
    KMSimilarMoviesSource* source = [KMSimilarMoviesSource similarMoviesSource];
    [source getSimilarMovies:movieDetails.movieId numberOfPages:@"1" completion:completionBlock];
}

- (void)processSimilarMoviesData:(NSArray*)data
{
    
    if (!self.similarMoviesDataSource)
        self.similarMoviesDataSource = [[NSMutableArray alloc] init];
    self.similarMoviesDataSource = [NSMutableArray arrayWithArray:data];
    [self setCollectionViewDataSourceDelegate: self];
}



#pragma mark -
#pragma mark UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [self.similarMoviesDataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *CellIdentifier = @"KMSimilarMoviesCollectionViewCell";
    
    KMSimilarMoviesCollectionViewCell *cell = (KMSimilarMoviesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        CGRect similarFrame = CGRectMake(0, 0, self.frame.size.width, 143);
        cell = [[KMSimilarMoviesCollectionViewCell alloc] initWithFrame:similarFrame];
    }
    
    NSURL *url =  [NSURL URLWithString:[[self.similarMoviesDataSource objectAtIndex:indexPath.row] movieThumbnailPosterImageUrl]];
    
    [cell.cellImageView  sd_setImageWithURL:url];
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    DetailViewController* viewController = [[DetailViewController alloc]init];
    viewController.movieDetails = [self.similarMoviesDataSource objectAtIndex:indexPath.row];
    [_context.navigationController pushViewController:viewController animated:YES];
}


@end
