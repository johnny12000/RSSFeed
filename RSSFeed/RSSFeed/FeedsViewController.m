//
//  FirstViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FeedsViewController.h"


@interface FeedsViewController ()

@property RssReader* rssReader;
@property NSMutableArray* feeds;
@property RssRepository* repository;
@property NSArray* sources;

@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(self.rssReader == nil)
        self.rssReader = [[RssReader alloc] init];
    
    if(self.repository == nil)
        self.repository = [[RssRepository alloc] init];
    
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) refreshData {
    //http://feeds.feedburner.com/techcrunch/startups?format=xml
    //http://www.b92.net/info/rss/vesti.xml
    
    self.sources = [self.repository getSources];
    
    self.feeds = [[NSMutableArray alloc]init];
    
    for (Source* source in self.sources) {
        [self.rssReader getDataFromUrl:source.url completionHandler:^(NSArray* data, NSError* connectionError){
            NSLog(@"Source : %@", source.name);
            [self.feeds addObjectsFromArray:data];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }];
    }
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"Cell";
    FeedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    Rss* rss = [self.feeds objectAtIndex:indexPath.row];
    NSPredicate* srcPredicate = [NSPredicate predicateWithFormat:@"url = %@", rss.channel];
    
    Source* source = [[self.sources filteredArrayUsingPredicate:srcPredicate] firstObject];
    
    [cell setCellModel:rss andSource:source];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"FeedDetailSegue"])
    {
        FeedDetailsViewController *vc = [segue destinationViewController];
        
        Rss* rss = [self.feeds objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
        NSPredicate* srcPredicate = [NSPredicate predicateWithFormat:@"url = %@", rss.channel];
        
        Source* source = [[self.sources filteredArrayUsingPredicate:srcPredicate] firstObject];
        
        [vc setModel:rss withSource:source];
    }
}


@end
