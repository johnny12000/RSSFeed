//
//  RssRepository.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/19/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "RssRepository.h"

@implementation RssRepository

static sqlite3* _database;
static RssRepository *_instance;

+ (RssRepository*) instance {
    if(_instance == nil)
    {
        _instance = [[RssRepository alloc]init];
    }
    return _instance;
}

- (id) init {
    if(self == [super init]){
        NSString *sqliteDb = [[NSBundle mainBundle] pathForResource:@"feeds" ofType:@"sqlite3"];
        
        if(sqlite3_open([sqliteDb UTF8String], &_database) != SQLITE_OK){
            NSLog(@"Failed to open database");
        }
    }
    
    return self;
}

- (NSArray*) feeds{
    return [[NSArray alloc]init];
}

- (NSArray*) sources{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT name, url, index_number, image FROM Sources";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *nameChars = (char *) sqlite3_column_text(statement, 0);
            char *cityChars = (char *) sqlite3_column_text(statement, 1);
            
//            
//            [NSData alloc]
//        initWithBytes:sqlite3_column_blob(query, 16)
//sqlite3_column_bytes(query, 16)];
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *city = [[NSString alloc] initWithUTF8String:cityChars];
            
            Source *src = [[Source alloc] initWithName:name url:city index:1 andImage:nil];
            [retval addObject:src];
            
        }
        sqlite3_finalize(statement);
    }
    
    return retval;
}

- (void) dealloc{
    
    sqlite3_close(_database);
    
}

@end
