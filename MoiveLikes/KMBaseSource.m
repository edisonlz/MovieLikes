//
//  KMBaseSource.m
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 03/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import "KMBaseSource.h"
#import "KMSourceConfig.h"
#import "KM_NSString+UrlEncoding.h"

#import "NSBundle+Loader.h"

@implementation KMBaseSource

#pragma mark -
#pragma mark Init Methods

- (id)init{
    self = [super init];
    if (self){
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

#pragma mark -
#pragma mark Response Data Parsing

- (NSDictionary*)dictionaryFromResponseData:(NSData*)responseData jsonPatternFile:(NSString*)jsonFile {
    NSDictionary* dictionary = nil;
    if (responseData ) {
        id object = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        if ([object isKindOfClass:[NSDictionary class]]){
            dictionary = (NSDictionary*)object;
        }
        else
        {
            if (object)
                dictionary = [NSDictionary dictionaryWithObject:object forKey:@"results"];
            else
                dictionary = nil;
        }
    }
    return dictionary;
}

@end
