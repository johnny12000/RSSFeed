//
//  RssRepository.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/19/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Source.h"
#import "Rss.h"

@interface RssRepository : NSObject{
    sqlite3 *_database;
}

+ (RssRepository*) instance;

- (NSArray*) getSources;
- (BOOL) addSource:(Source*)source;
- (BOOL) updateSource:(Source*)source;
- (BOOL) deleteSource:(Source*)source;


- (NSArray*) getFavorites;
- (BOOL) addFavorite:(Rss*)rss;
- (BOOL) removeFavorite:(Rss*)rss;


@end
