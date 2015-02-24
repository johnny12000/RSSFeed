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

@property NSString* key;
@property NSMutableString* value;

@property NSString * channel;

@end


@implementation RssParser


- (NSArray*) getRssArrayFromData:(NSData*)data {
    
    self.value = [[NSMutableString alloc] init];
    
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
    
    //NSLog(@"Started Element %@", elementName);
    
    if([elementName isEqualToString:@"channel"])
        self.result = [[NSMutableArray alloc]init];
    
    if([elementName isEqualToString:@"item"])
    {
        self.item = [[Rss alloc]init];
    }
    
    if([elementName isEqualToString:@"media:thumbnail"]) {
        
        NSURL *url = [NSURL URLWithString:[attributeDict valueForKey:@"url"]];
        [self.item setValue:[NSData dataWithContentsOfURL:url] forKey:@"image"];
    }
    
    [self.value setString:@""];
}

- (void) parser:(NSXMLParser*)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName {
    
    //NSLog(@"Found an element named: %@ with a value of: %@", elementName, self.value);
    
    if([elementName isEqualToString:@"channel"]) {
        self.channel = [self.value copy];
    }
    
    if([elementName isEqualToString:@"item"]) {
        [self.result addObject:self.item];
    }
    
    if([elementName isEqualToString:@"title"]) {
        
        self.item.title =  [self.value copy];
    }
    
    if([elementName isEqualToString:@"link"]) {
        [self.item setValue:[self.value copy] forKey:@"url"];
    }
    
    if([elementName isEqualToString:@"url"]) {
        NSURL *url = [NSURL URLWithString:self.value];
        [self.item setValue:[NSData dataWithContentsOfURL:url] forKey:@"image"];
    }
    
    if ([elementName isEqualToString:@"pubDate"]){
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, dd MMM YYYY hh:mm:ss ZZZ"];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
        
        [self.item setValue:[formatter dateFromString:self.value] forKey:@"date"];
    }
    
    if([elementName isEqualToString:@"description"]) {
        [self.item setValue:[self.value copy] forKey:@"shortDescription"];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.value appendString:string];
    //NSLog(@"Value: %@", self.value);
}


@end
