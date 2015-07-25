//
//  KMPhotoTimelineDetailsCell.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 04/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "KMGillSansLabel.h"

@interface KMMovieDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;


@property (weak, nonatomic) IBOutlet UIButton *watchTrailerButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;

+ (KMMovieDetailsCell*) movieDetailsCell;

@end
