//
//  FeedTableViewCell.m
//  RSSFeed
//
//  Created by nristic on 2/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setCellModel:(Rss*)feed {
    
    self.feedTitleLabel.text = feed.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY HH:mm"];
    
    self.feedDateLabel.text = [dateFormatter stringFromDate:feed.date];
    //self.sourceImageView.image =
    self.feedImageView.image = [[UIImage alloc] initWithData:feed.image];
    
    [self.isFavoriteImageView setHidden:TRUE];
    
    
}

@end
