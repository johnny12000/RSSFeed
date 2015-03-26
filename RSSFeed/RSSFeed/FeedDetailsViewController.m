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
@property Source* source;
@property ManagedRssRepository* repository;
@property RssReader* reader;

@end

@implementation FeedDetailsViewController

#pragma mark - Initalization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    return [self initWithCoder:coder repository:[ManagedRssRepository instance] reader:[[RssReader alloc] init]];
}

- (instancetype)initWithCoder:(NSCoder *)coder repository:(ManagedRssRepository*)rssRepo reader:(RssReader*)rssReader
{
    self = [super initWithCoder:coder];
    if (self) {
        self.repository = rssRepo;
        self.reader = rssReader;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentWebView.delegate = self;
    self.contentWebView.scrollView.scrollEnabled = NO;
    
    self.navigationItem.title = self.feed.title;
    
    self.feedImageView.image = [UIImage imageWithData:self.feed.image];
    self.feedTitleLabel.text = self.feed.title;
    self.feedDateLabel.text = [self.feed.date getDateString];
    self.feedDescriptionLabel.text = self.feed.shortdescription;
    self.sourceImageView.image = [UIImage imageWithData:self.source.image];
    
    id content = [self.reader getContentOfUrl:[NSURL URLWithString: self.feed.url]];
    [self.contentWebView loadRequest:content];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = self.contentWebView.frame;
    frame.size.height = self.contentWebView.scrollView.contentSize.height;
    self.contentWebView.frame = frame;
    
    self.feedScrollView.contentSize = frame.size;
    
    [self.contentWebView sizeToFit];
    
    self.webViewHeightConstraint.constant = frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)setFavorite:(id)sender {
    
    self.feed.isFavorite = self.feed.isFavorite ?  [NSNumber numberWithBool:FALSE] : [NSNumber numberWithBool:TRUE];
    NSError* error = nil;
    BOOL result = [self.repository saveRepository:&error];
    
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
