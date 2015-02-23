//
//  Rss.h
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rss : NSObject

@property NSData* image;
@property NSString* channel;
@property NSString* title;
@property NSDate* date;
@property NSURL* url;

@property NSString* shortDescription;
@property NSString* content;

@property BOOL isFavorite;

@end