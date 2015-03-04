//
//  ChannelParser.m
//  RSSFeed
//
//  Created by nristic on 3/4/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "ChannelParser.h"
@interface ChannelParser ()

@property BOOL channel;
@property BOOL isUrl;
@property NSMutableString* imageUrl;

@end


@implementation ChannelParser

- (NSData*) getChannelImage:(NSData*)url {
    
    self.imageUrl = [[NSMutableString alloc] init];
    
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:url];
    parser.delegate = self;
    [parser parse];
    
    return [NSData dataWithContentsOfURL:[NSURL URLWithString: self.imageUrl]];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"image"]){
        self.channel = TRUE;
    }
    else if(self.channel && [elementName isEqualToString:@"url"]){
        self.isUrl = TRUE;
    }
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"image"]){
        self.channel = FALSE;
    }
    else if(self.channel && [elementName isEqualToString:@"url"]){
        self.isUrl = FALSE;
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if(self.channel && self.isUrl)
        [self.imageUrl appendString:string];
}

@end
