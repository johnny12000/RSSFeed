//
//  Source.h
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Source : NSObject

@property NSData *image;
@property NSString *name;
@property NSString *url;
@property NSInteger index;

- (id) initWithName:(NSString*)name url:(NSString*)url index:(NSInteger)index andImage:(NSObject*)image;

@end
