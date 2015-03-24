//
//  Rss+Notifications.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/26/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "Rss+Notifications.h"

@implementation Rss (Notifications)

- (void) notifyFeedAddedToFavorites {
    
    NSNotification *notification = [NSNotification notificationWithName:NOTIFICATION_NEW_FAVORITE object:self];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
