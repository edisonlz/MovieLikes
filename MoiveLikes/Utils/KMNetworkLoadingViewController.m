//
//  KMNetworkLoadingViewController.m
//  BigCentral
//
//  Created by Kevin Mindeguia on 19/11/2013.
//  Copyright (c) 2013 iKode Ltd. All rights reserved.
//

#import "KMNetworkLoadingViewController.h"

@interface KMNetworkLoadingViewController ()

@end

@implementation KMNetworkLoadingViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showLoadingView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.activityIndicatorView startAnimating];
}

- (void)showLoadingView
{
    
    int loading_size = 50;
    int center_x = self.view.bounds.size.width / 2  - loading_size/2 ;
    int center_y = self.view.bounds.size.width / 2  - loading_size/2 ;

    if(!self.activityIndicatorView){
        int loading_size = 50;
        self.activityIndicatorView = [[KMActivityIndicator alloc]initWithFrame:CGRectMake(center_x, center_y, loading_size, loading_size)];
        
        self.activityIndicatorView.color = [UIColor colorWithRed:232.0/255.0f green:35.0/255.0f blue:111.0/255.0f alpha:1.0];
        
        [self.view addSubview: self.activityIndicatorView];
    };
}

@end
