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

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    return [self initWithCoder:coder reader:[[RssReader alloc] init] andRepository:[ManagedRssRepository instance]];
}

- (instancetype) initWithCoder:(NSCoder *)coder reader:(RssReader*)rssReader andRepository:(ManagedRssRepository*)rssRepository
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_SOURCE_CHANGED
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification* notification){
            [self refreshData];
        }];
        
        if(self.rssReader == nil)
            self.rssReader = rssReader;
        
        if(self.repository == nil)
            self.repository = rssRepository;
        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:NOTIFICATION_SOURCE_CHANGED object:nil];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINib *nib = [UINib nibWithNibName:NIB_FEED_CELL bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NIB_FEED_CELL];
    
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
    
    Source* source = [self.sources getSourceForRss:rss];
    
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
        Source* source = [self.sources getSourceForRss:rss];
        
        [vc setModel:rss withSource:source];
    }
}


@end
