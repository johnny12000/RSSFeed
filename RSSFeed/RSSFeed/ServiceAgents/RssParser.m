//
//  RssParser.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/12/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "RssParser.h"
#import "Rss.h"

@interface RssParser()

@property (nonatomic) NSXMLParser *parser;
@property NSMutableArray *result;
@property Rss* item;

@end


@implementation RssParser


- (NSArray*) getRssArrayFromData:(NSData*)data{
    
    self.result = [[NSMutableArray alloc]init];

    self.parser = [[NSXMLParser alloc] initWithData:data];
    [self.parser setDelegate:self];
    [self.parser parse];
    
    return self.result;
}


- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary*)attributeDict {
    
    NSLog(@"Started Element %@", elementName);
    
    if([elementName isEqualToString:@"channel"])
        self.result = [[NSMutableArray alloc]init];
    
    if([elementName isEqualToString:@"item"])
    {
        self.item = [[Rss alloc]init];
    }
}

- (void) parser:(NSXMLParser*)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName {
    
    NSLog(@"Found an element named: %@ with a value of: %@", elementName, qName);
    if([elementName isEqualToString:@"item"])
        [self.result addObject:self.item];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    id element;
    if(element == nil)
        element = [[NSMutableString alloc] init];
    
    [element appendString:string];
    
}

@end
