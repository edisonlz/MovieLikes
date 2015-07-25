//
//  KMDiscoverListCell.h
//  MoiveLikes
//
//  Created by liu zheng on 15/7/20.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "KMGillSansLabel.h"

@interface KMDiscoverListCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *timelineImageView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *voteLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(NSInteger) width height:(NSInteger) height padding:(NSInteger) padding ;
@end
