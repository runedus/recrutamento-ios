//
//  TraktController.h
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "BOLD_Test-Swift.h"
#import "Constants.h"

@interface TraktController : NSObject

@property AFHTTPRequestOperationManager *manager;

-(void)getPopularShowsWithSuccess:(void (^)(NSArray* popularShows))sucess
                          failure:(void (^)(NSString* errorMsg))error;
@end
