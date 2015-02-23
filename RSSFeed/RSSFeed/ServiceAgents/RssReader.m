//
//  RssReader.m
//  RSSFeed
//
//  Created by nristic on 2/9/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "RssReader.h"
#import "RssParser.h"

@interface RssReader()

@end

@implementation RssReader

- (void) getDataFromUrl:(NSString*)url completionHandler:(void (^)(NSArray* data, NSError* connectionError)) handler{
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
                               
                               NSArray *result = nil;
                               
                               if(!connectionError)
                               {
                                   RssParser* parser = [[RssParser alloc]init];
                                   result = [parser getRssArrayFromData:data];
                               }
                               
                               handler(result, connectionError);
                           }];
}



@end