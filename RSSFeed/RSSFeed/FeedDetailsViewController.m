//
//  FeedDetailsViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FeedDetailsViewController.h"

@interface FeedDetailsViewController ()

@property Rss* feed;

@end

@implementation FeedDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.feedImageView.image = [UIImage imageWithData:self.feed.image];
    self.feedTitleLabel.text = self.feed.title;
    NSDateFormatter* formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEE, dd MMM YYYY hh:mm:ss ZZZ"];
    
    self.feedDateLabel.text = [formatter stringFromDate: self.feed.date];
    self.feedDescriptionLabel.text = self.feed.description;
    self.feedTextLabel.text = self.feed.content;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Model

- (void) setModel:(Rss*)feed {
    self.feed = feed;
}

@end
