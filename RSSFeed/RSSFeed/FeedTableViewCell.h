//
//  FeedTableViewCell.h
//  RSSFeed
//
//  Created by nristic on 2/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rss.h"
#import "Source.h"
#import "Constants.h"
#import "NSDate+Formats.h"

@interface FeedTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *feedImageView;
@property (strong, nonatomic) IBOutlet UILabel *feedTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedDateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sourceImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isFavoriteImageView;

- (void) setCellModel:(Rss*)feed andSource:(Source*)source index:(int)index;

@end
