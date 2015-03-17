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

- (void) initializeWithUid:(NSString *)uid name:(NSString *)name url:(NSString *)url index:(NSInteger)index andImage:(NSData *)image andIsUsed:(BOOL)isUsed {
    self.uid = nil;
    self.name = @"";
    self.url = @"";
    self.index = [NSNumber numberWithInt:0];
    self.image = nil;
    self.isUsed = [NSNumber numberWithBool:TRUE];
}

@end
