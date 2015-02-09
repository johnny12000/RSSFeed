//
//  RssReader.m
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "RssReader.h"

@implementation RssReader

- (void) getDataFromUrl:(NSString*)url completionHandler:(void (^)(NSArray* data, NSError* connectionError)) handler{
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
                               
                               NSMutableArray *result = nil;
                               if(!connectionError)
                               {
                                    result = [[NSMutableArray alloc]init];
                                   //TODO: Convert data to RSS objects
                                   //NSString *content = [NSString stringWithUTF8String:[data bytes]];
                               }
                               handler(result, connectionError);
                           }];
}

@end
