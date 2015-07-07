//
//  TraktController.m
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

#import "TraktController.h"

@implementation TraktController

-(void)getPopularShowsWithSuccess:(void (^)(NSArray* popularShows))sucess
                          failure:(void (^)(NSString* errorMsg))failure{
    if (!self.manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"2" forHTTPHeaderField:@"trakt-api-version"];
    [requestSerializer setValue:TRAKT_API_CLIENT_ID forHTTPHeaderField:@"trakt-api-key"];
    self.manager.requestSerializer = requestSerializer;
    
    [self.manager GET:TRAKT_API_POPULAR_SHOWS_URL
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSMutableArray *showsArray = [NSMutableArray array];
                  for (NSDictionary *s in responseObject) {
                      Show *show = [[Show alloc] initWithTitle:s[@"title"]
                                                          year:[s[@"year"] integerValue]
                                                        images:s[@"images"]];
                      [showsArray addObject:show];
                  }
                  sucess(showsArray);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure([self traktAPIMessageForHTTPCode:error.code]);
              }];
    
}


-(NSString*)traktAPIMessageForHTTPCode:(NSInteger)code{
    NSString *message;
    switch (code) {
        case 400:
            //-- Bad Request
            message = TRAKT_BAD_REQUEST_MSG;
            break;
        case 403:
            //-- Forbidden
            message = TRAKT_FORBIDDEN_MSG;
            break;
        case 404:
            //-- Not Found
            message = TRAKT_NOT_FOUND_MSG;
            break;
        case 405:
            //-- Method Not Found
            message = TRAKT_METHOD_NOT_FOUND_MSG;
            break;
        case 500:
            //-- Server Error
            message = TRAKT_SERVER_ERROR_MSG;
            break;
        default:
            //-- Service Unavailable
            message = TRAKT_SERVICE_UNAVAILABLE_MSG;
            break;
            
    }
    return message;
}

@end