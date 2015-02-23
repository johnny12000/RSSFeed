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
    
    NSArray *result = [self.testRepository getSources];
    XCTAssertNotEqual(0, [result count]);
}

- (void)testUpdateSource{
    
    Source* src = [[Source alloc]initWithName:@"test1" url:@"url" index:2 andImage:nil];
    BOOL result = [self.testRepository updateSource:src];
    XCTAssertTrue(result);
    
}

- (void) testGetFavorites{
    NSArray *result = [self.testRepository getFavorites];
    XCTAssertEqual(0, [result count]);
    
}


- (void) testAddSource {
    
    
    Source* src = [[Source alloc]initWithName:@"testAdd" url:@"urlAdd" index:4 andImage:nil];
    BOOL result = [self.testRepository addSource:src];
    XCTAssertTrue(result);
    
}


@end
