//
//  KMNetworkLoadingViewController.h
//  BigCentral
//
//  Created by Kevin Mindeguia on 19/11/2013.
//  Copyright (c) 2013 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMActivityIndicator.h"

@protocol KMNetworkLoadingViewDelegate <NSObject>

-(void)retryRequest;

@end

@interface KMNetworkLoadingViewController : UIViewController

@property (strong, atomic)  KMActivityIndicator *activityIndicatorView;
@property (strong, atomic) id <KMNetworkLoadingViewDelegate> delegate;

- (void)showLoadingView;


@end
