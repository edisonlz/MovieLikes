//
//  DetailViewController.m
//  MoiveLikes
//
//  Created by liu zheng on 15/7/21.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "DetailViewController.h"
#import "KMMovieDetailsSource.h"
#import "KMSimilarMoviesSource.h"
#import "UIImageView+WebCache.h"
#import "KMMovieDetailsCell.h"
#import "KMSimilarMoviesCollectionViewCell.h"
#import "KMMovieDetailsSimilarMoviesCell.h"
#import "KMMovieDetailsCommentsCell.h"
#import "KMMoiveCommentCell.h"


#define moiveDetailHeight  120
#define movieSimilarHeight  143
#define moviceCommentHeight  500
#define moviceDefaultHeight  100

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate, KMDetailsPageDelegate>
@property (nonatomic, strong) NSMutableArray* similarMoviesDataSource;
@property (assign) CGPoint scrollViewDragPoint;
@end

@implementation DetailViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
   
   
    [self setupDetailsPageView];
    [self styleNavBar:64];
    [self setupNavbarButtons];
    [self requestMovieDetails];
}


- (void)setupDetailsPageView
{
    if(!self.detailsPageView){
        self.detailsPageView = [[KMDetailsPageView alloc]initWithFrame:self.view.frame];
    }
    
    self.detailsPageView.tableViewDataSource = self;
    self.detailsPageView.tableViewDelegate = self;
    self.detailsPageView.delegate = self;
    self.detailsPageView.tableViewSeparatorColor = [UIColor clearColor];
    [self.detailsPageView layoutSubviews];
    [self.view addSubview:self.detailsPageView];
    
}


#pragma mark -
#pragma mark Setup Navigation Bar
- (void)styleNavBar:(NSInteger) height {
    //1.hidden system nav
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    
    UIColor *navColor =  [UIColor colorWithRed:192.0/255 green:55.0/255 blue:45/255.0 alpha:0.5];
    
    newNavBar.barTintColor = navColor;
    
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    newItem.title = self.movieDetails.movieTitle;
    
    NSDictionary * fontDict =   [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIColor whiteColor], NSForegroundColorAttributeName,
                                 [UIFont fontWithName:@"ArialMT" size:20.0],
                                 NSFontAttributeName,nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:fontDict];
    
    [newNavBar setItems:@[newItem]];
    
    newNavBar.hidden = YES;
    
    // 4. add the nav bar to the main view
    [self.view addSubview:newNavBar];
    
    [self.detailsPageView setNavBarView:newNavBar];
}



#pragma mark -
#pragma mark Setup Navigation back
- (void)setupNavbarButtons
{
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    
    buttonBack.frame = CGRectMake(10, 31, 30, 30);
    [buttonBack setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
  
    [buttonBack addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
}

- (IBAction)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark Network Request Methods


- (void)requestMovieDetails
{
    KMMovieDetailsCompletionBlock completionBlock = ^(KMMovie* movieDetails, NSString* errorString)
    {

        [self processMovieDetailsData:movieDetails];
    };
    
    KMMovieDetailsSource* source = [KMMovieDetailsSource movieDetailsSource];
    [source getMovieDetails:self.movieDetails.movieId completion:completionBlock];
}

#pragma mark -
#pragma mark Fetched Data Processing

- (void)processMovieDetailsData:(KMMovie*)data
{
    self.movieDetails = data;
    [self.detailsPageView reloadData];
}


#pragma mark -
#pragma mark UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            KMMovieDetailsCell *detailsCell = [tableView dequeueReusableCellWithIdentifier:@"KMMovieDetailsCell"];
            
            if(detailsCell == nil)
                detailsCell = [KMMovieDetailsCell movieDetailsCell];
            
            [detailsCell.posterImageView sd_setImageWithURL:[NSURL URLWithString:self.movieDetails.movieThumbnailBackdropImageUrl]];
            
            detailsCell.movieTitleLabel.text = self.movieDetails.movieTitle;
            detailsCell.genresLabel.text = self.movieDetails.movieGenresString;
            
            cell = detailsCell;
            break;
        }
        case 1:
        {
            KMMovieDetailsSimilarMoviesCell *contributionCell = [tableView dequeueReusableCellWithIdentifier:@"KMMovieDetailsSimilarMoviesCell"];
            
            if(contributionCell == nil)
                contributionCell = [KMMovieDetailsSimilarMoviesCell movieDetailsSimilarMoviesCell];
            
            [contributionCell setupView:self.movieDetails context:self];
            
            cell = contributionCell;
            
            break;
        }
        case 2:{
            
            static NSString *CellIdentifier = @"KMMoiveCommentCell.h";
            
            KMMoiveCommentCell *commentCell = (KMMoiveCommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, moviceCommentHeight);
                commentCell = [[KMMoiveCommentCell alloc]initWithFrame:frame];
            }
            [commentCell setupView:self.movieDetails];
            
            cell = commentCell;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    


}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A much nicer way to deal with this would be to extract this code to a factory class, that would return the cells' height.
    CGFloat height = 0;
    
    switch (indexPath.row) {
        case 0:
        {
            height = moiveDetailHeight;
            break;
        }
        case 1:
        {

            height = movieSimilarHeight;
            
            break;
        }
        case 2:
        {
            height = moviceCommentHeight;
            break;
        }
        default:
        {
            height = moviceDefaultHeight;
            break;
        }
    }
    
    return height;
}

#pragma mark -
#pragma mark KMDetailsPageDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.scrollViewDragPoint = scrollView.contentOffset;
}

- (CGPoint)detailsPage:(KMDetailsPageView *)detailsPageView tableViewWillBeginDragging:(UITableView *)tableView;
{
    return self.scrollViewDragPoint;
}

- (UIViewContentMode)contentModeForImage:(UIImageView *)imageView
{
    return UIViewContentModeTop;
}

- (UIImageView*)detailsPage:(KMDetailsPageView*)detailsPageView imageDataForImageView:(UIImageView*)imageView;
{
    __block UIImageView* blockImageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.movieDetails movieOriginalBackdropImageUrl]] completed:^ (UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if ([detailsPageView.delegate respondsToSelector:@selector(headerImageViewFinishedLoading:)])
            [detailsPageView.delegate headerImageViewFinishedLoading:blockImageView];
        
    }];
    
    return imageView;
}


- (void)detailsPage:(KMDetailsPageView *)detailsPageView tableViewDidLoad:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
 
    /*register layout */
    [tableView registerClass:[KMMoiveCommentCell class] forCellReuseIdentifier:@"KMMoiveCommentCell"];
}

- (void)detailsPage:(KMDetailsPageView *)detailsPageView headerViewDidLoad:(UIView *)headerView
{
    [headerView setAlpha:0.0];
    [headerView setHidden:YES];
}





@end
