//
//  NSString+ValidationTests.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/26/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Validation.h"

@interface NSString_ValidationTests : XCTestCase

@end

@implementation NSString_ValidationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsWebLinkTrue {
    XCTAssertTrue([@"http://www.test.com" isWebLink]);
}

- (void)testIsWebLinkFalse {
    XCTAssertFalse([@"notlink" isWebLink]);
}


@end
