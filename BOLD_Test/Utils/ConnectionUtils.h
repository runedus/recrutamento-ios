//
//  ConnectionUtils.h
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"
#import "Alert.h"
#import "Constants.h"

@interface ConnectionUtils : NSObject

@property BOOL isConnected;

+(id)sharedInstance;
-(void)startReachabilityCheck;
-(BOOL)hasInternetConnection;

@end
