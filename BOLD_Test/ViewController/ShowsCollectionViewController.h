//
//  ShowsCollectionViewController.h
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConnectionUtils.h"
#import "TraktController.h"
#import "ShowCell.h"
#import "Alert.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ShowsCollectionViewController : UICollectionViewController
@property NSArray *popularShowsArray;
@property UIRefreshControl *refreshControl;
@end
