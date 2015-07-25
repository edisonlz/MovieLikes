//
//  KMDiscoverListViewController.h
//  MoiveLikes
//
//  Created by liu zheng on 15/7/20.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMNetworkLoadingViewController.h"

@interface KMDiscoverListViewController : UIViewController

@property (strong,atomic) UIView *networkLoadingContainerView;
@property (strong,atomic) UITableView *tableView;

@end
