//
//  FirstViewController.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssReader.h"
#import "FeedTableViewCell.h"
#import "FeedDetailsViewController.h"

@interface FeedsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *feedsTable;

@end

