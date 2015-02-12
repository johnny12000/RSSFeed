//
//  RssReaderTests.m
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RssReader.h"

@interface RssReaderTests : XCTestCase

@end

@implementation RssReaderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReadRssStream {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
    __block BOOL hasCalledBack = NO;
    
    void (^completionBlock)(NSArray* data, NSError* connectionError) = ^(NSArray* data, NSError* connectionError){
        NSLog(@"Completion Block!");
        NSLog(@"Number of items: %lu", (unsigned long)[data count]);
        
        XCTAssertNotEqual(0, [data count]);
        
        hasCalledBack = YES;
    };
    
    
    RssReader *rdr = [[RssReader alloc]init];
    [rdr getDataFromUrl:@"http://feeds.feedburner.com/TechCrunch/Apple" completionHandler:completionBlock];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack)
    {
        XCTFail(@"Callback method was not invoked");
    }
    
}


@end
