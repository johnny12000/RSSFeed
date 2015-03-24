//
//  NSArray+Filters.m
//  RSSFeed
//
//  Created by nristic on 3/24/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "NSArray+Filters.h"

@implementation NSArray (Filters)

- (Source*) getSourceForRss:(Rss*)rss {
    
    NSPredicate* srcPredicate = [NSPredicate predicateWithFormat:@"url = %@", rss.channel];
    Source* source = [[self filteredArrayUsingPredicate:srcPredicate] firstObject];
    return source;
    
}

@end
