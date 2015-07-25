//
//  KMMovieDetailsCommentsCell.m
//  MoiveLikes
//
//  Created by liu zheng on 15/7/22.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "KMMovieDetailsCommentsCell.h"

@implementation KMMovieDetailsCommentsCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void) setupView {
    
    
    if(!_headerImageView){
        CGRect Imageframe = CGRectMake(10, 10, 50, 50);
        _headerImageView = [[UIImageView alloc] initWithFrame:Imageframe];
        _headerImageView.layer.cornerRadius = _headerImageView.frame.size.width/2;
        _headerImageView.layer.masksToBounds = true;
        [self addSubview:_headerImageView];
    }
    
    if(!_userName){
        CGRect userlabelframe = CGRectMake(70, 10, 100, 30);
        _userName = [[UILabel alloc]initWithFrame:userlabelframe];
        [self addSubview:_userName];
    }
    
    if(!_comment){
        
        NSInteger width = self.frame.size.width - 70 - 20;
        CGRect userlabelframe = CGRectMake(70, 30, width, 90);
        _comment = [[UILabel alloc]initWithFrame:userlabelframe];
        [_comment setNumberOfLines:3];
        [self addSubview:_comment];
    }
    
}

@end
