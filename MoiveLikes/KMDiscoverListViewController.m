//
//  KMDiscoverListViewController.m
//  MoiveLikes
//
//  Created by liu zheng on 15/7/20.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "KMDiscoverListViewController.h"
#import "StoryBoardUtilities.h"
#import "KMDiscoverListCell.h"
#import "KMDiscoverSource.h"
#import "KMMovie.h"
#import "DetailViewController.h"


@interface KMDiscoverListViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@end

@implementation KMDiscoverListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self requestMovies];
}

-(void) setupView {
    
    NSInteger barHeight = 64;
    [self styleNavBar:barHeight];
    NSInteger startY = barHeight;
    [self setupTableView:startY];
    
}


#pragma mark -
#pragma mark Set Navitation Bar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self setupView];
}


- (void)styleNavBar:(NSInteger) height {
    //1.hidden system nav
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    
    UIColor *navColor =  [UIColor colorWithRed:192.0/255 green:55.0/255 blue:45/255.0 alpha:0.5];

    newNavBar.barTintColor = navColor;
    
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    newItem.title = @"Discover";
    [newNavBar setItems:@[newItem]];
    
    
    // 4. add the nav bar to the main view
    [self.view addSubview:newNavBar];
}

#pragma mark -
#pragma mark Set setupTableView


-(void) setupTableView:(NSInteger)startY {
    
    if(!self.tableView){
    
        CGRect tableSize = CGRectMake(self.view.bounds.origin.x,
                   self.view.bounds.origin.y+startY,
                   self.view.bounds.size.width, self.view.bounds.size.height-startY);
        
        self.tableView = [[UITableView alloc] initWithFrame:tableSize style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview: self.tableView];
    }
    
    if(!self.refreshControl){
        self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self.refreshControl addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
        [self.tableView  addSubview:_refreshControl];
    }

}


#pragma mark -
#pragma mark Network Requests methods

- (void)refreshFeed
{
    [self requestMovies];
}

- (void)requestMovies
{
    KMDiscoverListCompletionBlock completionBlock = ^(NSArray* data, NSString* errorString)
    {
        [self.refreshControl endRefreshing];
        
        [self processData:data];
    };
    
    KMDiscoverSource* source = [KMDiscoverSource discoverSource];
    [source getDiscoverList:@"1" completion:completionBlock];
}

#pragma mark -
#pragma mark Fetched Data Processing

- (void)processData:(NSArray*)data
{

    [self hideLoadingView];
        
    if (!self.dataSource)
        self.dataSource = [[NSMutableArray alloc] init];
        
    self.dataSource = [NSMutableArray arrayWithArray:data];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark KMNetworkLoadingViewDelegate

-(void)retryRequest;
{
    [self requestMovies];
}



#pragma mark -
#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"KMDiscoverListCell";
    
    KMDiscoverListCell *cell = (KMDiscoverListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[KMDiscoverListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier width:self.view.bounds.size.width height:200 padding:1];
    }
    
    NSURL *url = [NSURL URLWithString:[[self.dataSource objectAtIndex:indexPath.row] movieOriginalBackdropImageUrl]];
    NSString *title= [[self.dataSource objectAtIndex:indexPath.row] movieTitle];
    NSString *voteAverage= [[self.dataSource objectAtIndex:indexPath.row] movieVoteAverage];
    
    [cell.timelineImageView sd_setImageWithURL:url];
    [cell.titleLabel setText:title];
    [cell.voteLabel setText:voteAverage];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DetailViewController* viewController = [[DetailViewController alloc]init];
    viewController.movieDetails = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}



#pragma mark -
#pragma mark KMNetworkLoadingViewController Methods

- (void)hideLoadingView
{
//    [UIView transitionWithView:self.view duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
//        
//        [self.networkLoadingContainerView removeFromSuperview];
//        
//    } completion:^(BOOL finished) {
//        [self.networkLoadingViewController removeFromParentViewController];
//        self.networkLoadingContainerView = nil;
//    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
