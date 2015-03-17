//
//  Source.m
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "Source.h"

@implementation Source

@dynamic uid;
@dynamic image;
@dynamic name;
@dynamic url;
@dynamic index;
@dynamic isUsed;

- (id) initWithName:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSData*)image andIsUsed:(BOOL)isUsed {
    return [self initWithUid:[[NSUUID UUID] UUIDString] name:name url:url index:index andImage:image andIsUsed:isUsed];
}

- (id) initWithUid:(NSString*)uid name:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSData*)image andIsUsed:(BOOL)isUsed {
    
    Source* src = [NSEntityDescription insertNewObjectForEntityForName:@"Source"
                                                inManagedObjectContext:[ManagedRssRepository instance].context];
    src.uid = uid;
    src.name = name;
    src.url = url;
    src.index = [NSNumber numberWithInt:index];
    src.image = image;
    src.isUsed = [NSNumber numberWithBool:isUsed];
    
    return src;
}

+ (Source*) newSource {
    Source* src = [NSEntityDescription insertNewObjectForEntityForName:@"Source"
                                                inManagedObjectContext:[ManagedRssRepository instance].context];
    src.uid = nil;
    src.name = @"";
    src.url = @"";
    src.index = [NSNumber numberWithInt:0];
    src.image = nil;
    src.isUsed = [NSNumber numberWithBool:TRUE];
    
    return src;
}

@end
