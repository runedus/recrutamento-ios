//
//  ConnectionUtils.m
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

#import "ConnectionUtils.h"

@implementation ConnectionUtils

+(id)sharedInstance{
    static dispatch_once_t token = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&token, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(id)init{
    self = [super init];
    if (self){
        self.isConnected = NO;
    }
    return self;
}

-(void)startReachabilityCheck{
    Reachability* reach = [Reachability reachabilityWithHostname:GOOGLE_URL];
    
    reach.reachableBlock = ^(Reachability*reach){
        NSLog(@"Com Internet!");
        [[ConnectionUtils sharedInstance] setIsConnected:YES];
    };
    
    reach.unreachableBlock = ^(Reachability*reach){
        NSLog(@"Sem Internet!");
        [[ConnectionUtils sharedInstance] setIsConnected:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showNoInternetAlert];
        });
    };
    
    [reach startNotifier];
}

-(BOOL)hasInternetConnection{
    if (!self.isConnected) {
        [self showNoInternetAlert];
    }
    return self.isConnected;
}

-(void)showNoInternetAlert{
    Alert *alert = [[Alert alloc] initWithTitle:NO_INTERNET_MSG duration:2.0 completion:^{
    }];
    [alert setAlertType:AlertTypeError];
    [alert showAlert];
}

@end