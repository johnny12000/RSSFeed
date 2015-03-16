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
    if(self == [super init]){
        self.uid = uid;
        self.name = name;
        self.url = url;
        //self.index = (NSNumber)index;
        self.image = image;
        //self.isUsed = (BOOL)isUsed;
    }
    
    return self;
}

@end
