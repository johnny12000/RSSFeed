//
//  RssRepositoryTests.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/19/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RssRepository.h"

@interface RssRepositoryTests : XCTestCase

@property RssRepository *testRepository;

@end

@implementation RssRepositoryTests

- (void)setUp {
    [super setUp];
    self.testRepository = [RssRepository instance];
}

- (void)tearDown {
    [super tearDown];
}

//tests to see if data is retrieved from dummy database
- (void)testGetSources {
    
    NSArray *result = [self.testRepository sources];
    XCTAssertNotEqual(0, [result count]);
}

- (void) testGetFavorites{
    NSArray *result = [self.testRepository feeds];
    XCTAssertEqual(0, [result count]);
    
}



@end
