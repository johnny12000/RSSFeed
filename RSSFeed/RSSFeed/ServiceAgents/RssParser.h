//
//  RssParser.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/12/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssParser : NSObject <NSXMLParserDelegate>

- (NSArray*) getRssArrayFromData:(NSData*)data fromChannel:(NSString*)url;

@end
