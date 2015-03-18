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
@property ManagedRssRepository* repository;
@property NSArray* sources;
@property NSArray* favorites;

@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(self.rssReader == nil)
        self.rssReader = [[RssReader alloc] init];
    
    if(self.repository == nil)
        self.repository = [ManagedRssRepository instance];
        
    UINib *nib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FeedCell"];
    
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
    
    NSPredicate* filterSources = [NSPredicate predicateWithFormat:@"isUsed = TRUE"];
    
    self.sources = [[self.repository getSources] filteredArrayUsingPredicate:filterSources];
    
    self.favorites = [self.repository getFavorites];
    
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
    
    static NSString *simpleTableIdentifier = @"FeedCell";
    FeedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    Rss* rss = [self.feeds objectAtIndex:indexPath.row];
    NSPredicate* srcPredicate = [NSPredicate predicateWithFormat:@"url = %@", rss.channel];
    
    Source* source = [[self.sources filteredArrayUsingPredicate:srcPredicate] firstObject];
    
    NSURL*url = [NSURL URLWithString:rss.url];
    
    NSPredicate* isFavPredicate = [NSPredicate predicateWithFormat:@"url = %@", url.absoluteString];
    BOOL isFavorite = [self.favorites filteredArrayUsingPredicate:isFavPredicate].count != 0;
    
    [cell setCellModel:rss andSource:source index:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"FeedDetailSegue" sender:self];
}

#pragma mark - Navigation

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
