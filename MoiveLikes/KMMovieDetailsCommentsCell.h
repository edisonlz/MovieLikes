//
//  KMMovieDetailsCommentsCell.h
//  MoiveLikes
//
//  Created by liu zheng on 15/7/22.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface KMMovieDetailsCommentsCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *headerImageView;
@property (strong, nonatomic)  UILabel *userName;
@property (strong, nonatomic)  UILabel *comment;

@end
