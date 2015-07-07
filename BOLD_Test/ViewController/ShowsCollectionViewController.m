//
//  ShowsCollectionViewController.m
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

#import "ShowsCollectionViewController.h"


@interface ShowsCollectionViewController ()

@end

@implementation ShowsCollectionViewController

static NSString * const reuseIdentifier = @"ShowCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    _popularShowsArray = [NSArray array];
    
    //-- Adiciona pull to refresh
    _refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadPopularShows) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadPopularShows];
}

-(void)loadPopularShows{
    if ([[ConnectionUtils sharedInstance] hasInternetConnection]) {
        TraktController *controller = [[TraktController alloc] init];
        [controller getPopularShowsWithSuccess:^(NSArray *popularShows) {
            self.popularShowsArray = popularShows;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
        } failure:^(NSString *errorMsg) {
            [self showAlertWithTitle:@"Atenção" andMesssage:errorMsg];
        }];
    }
    [self.refreshControl endRefreshing];
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.popularShowsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Show *s = self.popularShowsArray[indexPath.row];
    [cell.showThumbImage setImageWithURL:[NSURL URLWithString:[s posterThumbURL]]];
    cell.showTitleLabel.text = s.title;
    
    return cell;
}

-(void)showAlertWithTitle:(NSString*)title andMesssage:(NSString*)mesage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:mesage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end