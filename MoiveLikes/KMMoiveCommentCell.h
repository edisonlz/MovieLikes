//
//  KMMoiveCommentCell.h
//  MoiveLikes
//
//  Created by liu zheng on 15/7/25.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMMovie.h"

@interface KMMoiveCommentCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>
@property (atomic,strong) UITableView * tableView;

- (void) setupView:(KMMovie*) movieDetails ;
@end
