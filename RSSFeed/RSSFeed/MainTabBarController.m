//
//  MainTabBarController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/26/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@property NSInteger numberOfNewFavorites;

@end


@implementation MainTabBarController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.numberOfNewFavorites = 0;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_NEW_FAVORITE object:nil queue:nil usingBlock:^(NSNotification* notification){
            self.numberOfNewFavorites++;
            
            UITabBarItem *tabBarItem = [[self.mainTabBar items] objectAtIndex:1];
            
            [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld", (long)self.numberOfNewFavorites]];
            
        }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:NOTIFICATION_NEW_FAVORITE object:nil];
}


@end
