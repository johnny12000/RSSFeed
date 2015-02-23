//
//  SourcesViewController.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEditSourceViewController.h"

@interface SourcesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *sourcesTable;

- (IBAction)setSourceDelete:(id)sender;

@end
