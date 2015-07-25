//
//  KMDiscoverListCell.m
//  MoiveLikes
//
//  Created by liu zheng on 15/7/20.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "KMDiscoverListCell.h"

@interface KMDiscoverListCell ()
//@property (atomic) CGRect *frame;
@end

@implementation KMDiscoverListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(NSInteger) width height:(NSInteger) height padding:(NSInteger) padding
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        if (!_timelineImageView) {
            _timelineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height - padding)];
            [self addSubview:_timelineImageView];
        }
        
        if(!_titleLabel){
            
            NSInteger font_height = 30;
            CGRect labelRect = CGRectMake(0, height - font_height, width, font_height);
            _titleLabel = [[UILabel alloc]initWithFrame:labelRect];
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            //_titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self addSubview:_titleLabel];
        }
        
        if(!_voteLabel){
            NSInteger font_height = 30;
            NSInteger font_width = 30;
            CGRect labelRect = CGRectMake(width - font_width, height - font_height, width, font_height);
            _voteLabel = [[UILabel alloc]initWithFrame:labelRect];
            UIColor *voteColor =  [UIColor colorWithRed:192.0/255 green:55.0/255 blue:45/255.0 alpha:0.8];
            _voteLabel.textColor = voteColor;
            _voteLabel.font = [UIFont systemFontOfSize:18];
            _voteLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:_voteLabel];
        }

        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


@end
