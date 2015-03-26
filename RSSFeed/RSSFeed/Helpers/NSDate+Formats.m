//
//  NSDate+Formats.m
//  RSSFeed
//
//  Created by nristic on 3/26/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "NSDate+Formats.h"

@implementation NSDate (Formats)

- (NSString*) getDateString {

    NSDateFormatter* formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:DATE_FORMAT];
    
    return [formatter stringFromDate: self];
    
}

@end
