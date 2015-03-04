//
//  RssParserTests.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/12/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RssParser.h"
#import "Rss.h"

@interface RssParserTests : XCTestCase

@property RssParser* parser;

@end

@implementation RssParserTests

@synthesize parser;

- (void)setUp {
    [super setUp];
    parser = [[RssParser alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSString * fileName = [[NSBundle bundleForClass:[self class]] pathForResource: @"RssChannelTest" ofType: @"txt"];
    
    NSData *testData = [[NSData alloc] initWithContentsOfFile:fileName];
    
    NSArray* result = [parser getRssArrayFromData:testData fromChannel:@"test"];
    
    NSUInteger number = [result count];
    
    for (Rss* rss in result) {
        XCTAssertEqual(@"test", rss.channel);
    }
    
    XCTAssertEqual(20, number);
}

@end
