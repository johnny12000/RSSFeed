//
//  Source.h
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedRssRepository.h"

@interface Source : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * isUsed;

- (id) initWithName:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSData*)image andIsUsed:(BOOL)isUsed;
- (id) initWithUid:(NSString*)uid name:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSData*)image andIsUsed:(BOOL)isUsed;
- (id) init;

+ (Source*) newSource;

@end
