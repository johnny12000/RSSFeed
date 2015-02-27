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
@property NSArray* feeds;

@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(self.rssReader == nil)
        self.rssReader = [[RssReader alloc] init];
    
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor magentaColor];
    self.refreshControl = refreshControl;
    
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
    [self.rssReader getDataFromUrl:@"http://feeds.feedburner.com/techcrunch/startups?format=xml" completionHandler:^(NSArray* data, NSError* connectionError){
        self.feeds = data;
        
        [self.tableView reloadData];
    }];
    
    
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"Cell";
    id cl = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    FeedTableViewCell *cell = cl;
    
    if (cell == nil) {
        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Rss* rss = [self.feeds objectAtIndex:indexPath.row];
    
    [cell setCellModel:rss];
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:@"geekPic.jpg"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"FeedDetailSegue"])
    {
        FeedDetailsViewController *vc = [segue destinationViewController];
        [vc setModel:[self.feeds objectAtIndex:self.tableView.indexPathForSelectedRow.row]];
    }
}


@end
