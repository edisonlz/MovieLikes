//
//  KMMoiveCommentCell.m
//  MoiveLikes
//
//  Created by liu zheng on 15/7/25.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "KMMoiveCommentCell.h"
#import "KMSimilarMoviesSource.h"
#import "DetailViewController.h"
#import "KMMovieDetailsCommentsCell.h"

#define kDefaultTableCellHeight 120.0f

@interface KMMoiveCommentCell()
@property (atomic,strong) NSMutableArray * commentsData;
@end


@implementation KMMoiveCommentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void) setupView:(KMMovie*) movieDetails {
    if(!_tableView){
        
        _tableView = [[UITableView alloc]initWithFrame:self.frame];
        
        //set delegete datasource
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [_tableView registerClass:[KMMovieDetailsCommentsCell class] forCellReuseIdentifier:@"KMMovieDetailsCommentsCell"];

        
        //self.tableView.separatorColor = self.tableViewSeparatorColor;
        [self addSubview: _tableView];
        [self requestSimilarMovies:movieDetails];
    }
}


#pragma mark -
#pragma mark Network request
- (void) requestSimilarMovies:(KMMovie*) movieDetails
{
    KMSimilarMoviesCompletionBlock completionBlock = ^(NSArray* data, NSString* errorString)
    {
        [self processSimilarMoviesData:data];
    };
    
    KMSimilarMoviesSource* source = [KMSimilarMoviesSource similarMoviesSource];
    [source getSimilarMovies:movieDetails.movieId numberOfPages:@"1" completion:completionBlock];
}

- (void) processSimilarMoviesData:(NSArray*)data
{
    
    if (!self.commentsData)
        self.commentsData = [[NSMutableArray alloc] init];
    self.commentsData = [NSMutableArray arrayWithArray:data];
    
    [self.tableView reloadData];

}



#pragma mark -
#pragma mark UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentsData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell* cell = nil;
            
        static NSString *CellIdentifier = @"KMMovieDetailsCommentsCell";
            
        KMMovieDetailsCommentsCell *commentCell = (KMMovieDetailsCommentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
                CGRect frame = CGRectMake(0, 0, self.frame.size.width, kDefaultTableCellHeight);
                commentCell = [[KMMovieDetailsCommentsCell alloc]initWithFrame:frame];
        }
    
        KMMovie *movie = [self.commentsData objectAtIndex:indexPath.row];
    
        NSURL *url = [NSURL URLWithString:movie.movieThumbnailPosterImageUrl];
            
        NSString *username =  movie.movieTitle;
        NSString *comment = movie.movieSynopsis;
            
        [commentCell.headerImageView sd_setImageWithURL:url];
        commentCell.userName.text =username;
        commentCell.comment.text = comment;
            
        cell = commentCell;
        return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDefaultTableCellHeight;
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



@end
