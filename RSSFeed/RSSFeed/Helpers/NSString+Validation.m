//
//  NSString+Validation.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/26/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL) isWebLink {
    NSString* pattern = @"(http|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
    NSError *error;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSRange textRange = NSMakeRange(0, self.length);
    NSRange range = [regex rangeOfFirstMatchInString:self options:NSMatchingReportProgress range:textRange];
    
    return range.location != NSNotFound;
}


@end
