//
//  RssEntity.h
//  RSSFeed
//
//  Created by nristic on 3/16/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Rss : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * channel;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * shortdescription;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * isFavorite;

@end