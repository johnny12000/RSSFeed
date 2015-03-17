//
//  FeedDetailsViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FeedDetailsViewController.h"
#import "RssReader.h"

@interface FeedDetailsViewController ()

@property Rss* feed;
@property Source* source;
@property ManagedRssRepository* repository;

@end

@implementation FeedDetailsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.repository = [ManagedRssRepository instance];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedImageView.image = [UIImage imageWithData:self.feed.image];
    
    self.feedTitleLabel.text = self.feed.title;
    
    NSDateFormatter* formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd.MM.YYYY HH:mm"];
    
    self.feedDateLabel.text = [formatter stringFromDate: self.feed.date];
    
    self.feedDescriptionLabel.text = self.feed.shortdescription;//.description;
    
    self.sourceImageView.image = [UIImage imageWithData:self.source.image];
    
    RssReader *rdr = [[RssReader alloc] init];
    
    id content = [rdr getContentOfUrl:[NSURL URLWithString: self.feed.url]];
    
    [self.contentWebView loadRequest:content];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)setFavorite:(id)sender {
    
    self.feed.isFavorite = self.feed.isFavorite ?  [NSNumber numberWithBool:FALSE] : [NSNumber numberWithBool:TRUE];
    
    BOOL result = [self.repository addFavorite:self.feed];
    
    if(result)
       [self.feed notifyFeedAddedToFavorites];
    
}

- (IBAction)shareFeed:(id)sender {
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.feed.url]
                                                                                         applicationActivities:nil];
    
    
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
}


#pragma mark - Model

- (void) setModel:(Rss*)feed withSource:(Source*)source {
    self.feed = feed;
    self.source = source;
}

@end
