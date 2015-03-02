//
//  Source.m
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "Source.h"

@implementation Source


- (id) initWithName:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSData*)image andIsUsed:(BOOL)isUsed {
    return [self initWithUid:[[NSUUID UUID] UUIDString] name:name url:url index:index andImage:image andIsUsed:isUsed];
}

- (id) initWithUid:(NSString*)uid name:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSData*)image andIsUsed:(BOOL)isUsed {
    if(self == [super init]){
        self.uid = uid;
        self.name = name;
        self.url = url;
        self.index = index;
        self.image = image;
        self.isUsed = isUsed;
    }
    
    return self;
}

@end
