//
//  ChannelParserTests.m
//  RSSFeed
//
//  Created by nristic on 3/4/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ChannelParser.h"

@interface ChannelParserTests : XCTestCase

@property ChannelParser* parser;

@end

@implementation ChannelParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.parser = [[ChannelParser alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testChannelParser {
    NSString * fileName = [[NSBundle bundleForClass:[self class]] pathForResource: @"RssChannelTest" ofType: @"txt"];
    
    NSData *testData = [[NSData alloc] initWithContentsOfFile:fileName];
    
    NSData* result = [self.parser getChannelImage:testData];
    
    XCTAssertNotNil(result);
    
}

@end
