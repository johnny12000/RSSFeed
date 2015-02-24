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
    
    
    self.feedsTable.delegate = self;
    self.feedsTable.dataSource = self;
    
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
        
        [self.feedsTable reloadData];
    }];
    
    
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"FeedCell";
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Rss* rss = [self.feeds objectAtIndex:indexPath.row];
    
    [cell setCellModel:rss];
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:@"geekPic.jpg"];
    
    return cell;
}


@end
