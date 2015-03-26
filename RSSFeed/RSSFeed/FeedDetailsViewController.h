//
//  FeedDetailsViewController.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rss.h"
#import "ManagedRssRepository.h"
#import "Rss+Notifications.h"
#import "Source.h"
#import "Constants.h"
#import "RssReader.h"
#import "NSDate+Formats.h"

@interface FeedDetailsViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *feedScrollView;

@property (strong, nonatomic) IBOutlet UIImageView *feedImageView;
@property (strong, nonatomic) IBOutlet UILabel *feedDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sourceImageView;
@property (strong, nonatomic) IBOutlet UILabel *feedDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIWebView *contentWebView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *webViewHeightConstraint;

- (IBAction)setFavorite:(id)sender;
- (IBAction)shareFeed:(id)sender;

- (void) setModel:(Rss*)feed withSource:(Source*)source;

@end
