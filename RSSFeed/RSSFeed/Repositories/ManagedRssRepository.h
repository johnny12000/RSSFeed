//
//  ManagedRssRepository.h
//  RSSFeed
//
//  Created by nristic on 3/17/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Source.h"
#import "Rss.h"

@class Source;
@class Rss;

@interface ManagedRssRepository : NSObject

@property (nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic, retain) NSManagedObjectModel* model;
@property (nonatomic, retain) NSPersistentStoreCoordinator* coordinator;

+ (ManagedRssRepository*) instance;

- (Rss*) createFeed;
- (Rss*) getFeedByUrl:(NSString*)url;
- (NSArray*) getFavorites;

- (Source*) createSource;
- (NSArray*) getSources;

- (void) deleteObject:(NSManagedObject*)object;

- (BOOL) saveRepository:(NSError**)error;

@end
