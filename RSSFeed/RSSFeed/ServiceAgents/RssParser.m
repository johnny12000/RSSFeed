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

@property BOOL isImageCDATA;
@property NSMutableString* imgLink;

@property ManagedRssRepository* repository;

@property NSData* image;
@property NSString* title;
@property NSDate* date;
@property NSString* url;
@property NSString* shortdescription;
@property NSString* content;

@end


@implementation RssParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.repository = [ManagedRssRepository instance];
    }
    return self;
}

- (NSArray*) getRssArrayFromData:(NSData*)data fromChannel:(NSString *)url {
    
    self.channel = url;
    
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
        //self.item = [self.repository createFeed];
        //self.item.channel = [self.channel copy];
    }
    
    if([elementName isEqualToString:@"media:thumbnail"]) {
        
        NSURL *url = [NSURL URLWithString:[attributeDict valueForKey:@"url"]];
        self.image = [NSData dataWithContentsOfURL:url];
    }

    if([elementName isEqualToString:@"imglink"]) {
        self.isImageCDATA = TRUE;
        self.imgLink = [NSMutableString stringWithString:@""];
    }
    
    [self.value setString:@""];
}

- (void) parser:(NSXMLParser*)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"item"]) {
        self.item = [self.repository getFeedByUrl:self.url];
        if(!self.item){
            self.item = [self.repository createFeed];
            
            self.item.channel = [self.channel copy];
            self.item.image = [self.image copy];
            self.item.title = [self.title copy];
            self.item.date = [self.date copy];
            self.item.url = [self.url copy];
            self.item.shortdescription = [self.shortdescription copy];
            self.item.content = [self.content copy];
            self.item.isFavorite = FALSE;
        }
        
        [self.result addObject:self.item];
    }
    
    if([elementName isEqualToString:@"title"]) {
        self.title = [self.value copy];
    }
    
    if([elementName isEqualToString:@"link"]) {
        self.url = [self.value copy];
    }
    
    if([elementName isEqualToString:@"url"]) {
        NSURL *url = [NSURL URLWithString:self.value];
        self.image = [NSData dataWithContentsOfURL:url];
    }
    
    if ([elementName isEqualToString:@"pubDate"]){
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, dd MMM YYYY hh:mm:ss ZZZ"];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
        self.date = [formatter dateFromString:self.value];
    }
    
    if([elementName isEqualToString:@"description"]) {
        self.shortdescription = [self.value copy];
    }
    
    if([elementName isEqualToString:@"imglink"]) {
        self.isImageCDATA = FALSE;
        
        NSURL *url = [NSURL URLWithString:self.imgLink];
        self.image = [NSData dataWithContentsOfURL:url];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.value appendString:string];
}

- (void) parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    if(self.isImageCDATA)
    {
        //extract image name from cdata
        
        NSString *text = [[NSString alloc] initWithData:CDATABlock encoding:NSASCIIStringEncoding];
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSRange range = NSMakeRange(0,10);
        text = [text stringByReplacingCharactersInRange:range withString:@"" ];
        text = [text stringByReplacingOccurrencesOfString:@"\" title=\"\" alt=\"\" />" withString:@""];
        
        [self.imgLink appendString:text];
    }
    
}

@end
