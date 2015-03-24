//
//  SecondViewController.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rss.h"
#import "ManagedRssRepository.h"
#import "FeedTableViewCell.h"
#import "FeedDetailsViewController.h"
#import "Constants.h"


@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
- (IBAction)deleteClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *favoritesTableView;

@end

