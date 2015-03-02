//
//  FeedTableViewCell.m
//  RSSFeed
//
//  Created by nristic on 2/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FeedTableViewCell.h"

@interface FeedTableViewCell()

@property Rss* feed;
@property Source* source;

@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setCellModel:(Rss*)feed andSource:(Source*)source isFavorite:(BOOL)isFavorite {
    
    self.feed = feed;
    self.source = source;
    
    self.feedTitleLabel.text = self.feed.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY HH:mm"];
    
    self.feedDateLabel.text = [dateFormatter stringFromDate:self.feed.date];
    self.sourceImageView.image = [UIImage imageWithData:source.image];
    self.feedImageView.image = [[UIImage alloc] initWithData:self.feed.image];
    
    [self.isFavoriteImageView setHidden:!isFavorite];
}

@end
