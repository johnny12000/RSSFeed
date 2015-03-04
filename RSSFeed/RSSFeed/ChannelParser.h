//
//  ChannelParser.h
//  RSSFeed
//
//  Created by nristic on 3/4/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelParser : NSObject <NSXMLParserDelegate>

- (NSData*) getChannelImage:(NSData*)url;

@end
