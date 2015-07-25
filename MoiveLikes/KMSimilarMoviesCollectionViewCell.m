//
//  KMSimilarMoviesCollectionViewCell.m
//  MoiveLikes
//
//  Created by liu zheng on 15/7/22.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "KMSimilarMoviesCollectionViewCell.h"
@interface KMSimilarMoviesCollectionViewCell ()
@end


@implementation KMSimilarMoviesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) setupView {
    if(!_cellImageView){
        
        CGRect imageFrame =  CGRectMake(0, 0, 46, 46);
        _cellImageView = [[UIImageView alloc]initWithFrame:imageFrame];
        
        _cellImageView.layer.cornerRadius = self.cellImageView.frame.size.width/2;
        _cellImageView.layer.masksToBounds = YES;
        
        [self addSubview: _cellImageView];
        
    }
}
@end
