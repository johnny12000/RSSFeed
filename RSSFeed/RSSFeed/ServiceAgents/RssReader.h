//
//  RssReader.h
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssReader : NSObject

- (void) getDataFromUrl:(NSString*)url completionHandler:(void (^)(NSArray* data, NSError* connectionError)) handler;

- (NSURLRequest*) getContentOfUrl:(NSURL*)url;

@end
