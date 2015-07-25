//
//  DetailViewController.h
//  MoiveLikes
//
//  Created by liu zheng on 15/7/21.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMMovie.h"
#import "KMDetailsPageView.h"


@interface DetailViewController : UIViewController


@property (strong, nonatomic) KMMovie* movieDetails;
@property (strong, nonatomic) KMDetailsPageView* detailsPageView;
- (IBAction)popViewController:(id)sender;

@end
