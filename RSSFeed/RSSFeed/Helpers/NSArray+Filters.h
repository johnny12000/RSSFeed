//
//  NSArray+Filters.h
//  RSSFeed
//
//  Created by nristic on 3/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Source.h"
#import "Rss.h"

@interface NSArray (Filters)

- (Source*) getSourceForRss:(Rss*)rss;

@end
