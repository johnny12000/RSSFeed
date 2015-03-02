//
//  RssRepository.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/19/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "RssRepository.h"

@implementation RssRepository

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

#pragma mark - Sources CRUD

- (NSArray*) getSources {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT uid, name, url, index_number, image, is_used FROM Sources";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSString *uid = [[NSString alloc] initWithUTF8String: (char*)sqlite3_column_text(statement, 0)];
            NSString *name = [[NSString alloc] initWithUTF8String: (char*)sqlite3_column_text(statement, 1)];
            NSString *url = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement, 2)];
            int index = sqlite3_column_int(statement, 3);
            NSData *imageData = [[NSData alloc]initWithBytes:sqlite3_column_blob(statement, 4) length:sqlite3_column_bytes(statement, 4)];
            BOOL isUsed = sqlite3_column_int(statement, 5);
            
            Source *src = [[Source alloc]  initWithUid:uid name:name url:url index:index andImage:imageData andIsUsed:isUsed];
            [retval addObject:src];
            
        }
        sqlite3_finalize(statement);
    }
    
    return retval;
}

- (BOOL) addSource:(Source*)source {
    
    NSString* query = [NSString stringWithFormat: @"INSERT INTO Sources (uid, name, url, image, index_number, is_used) VALUES ('%@', '%@', '%@', '%@', %ld, %d)", source.uid, source.name, source.url, source.image, source.index, source.isUsed];
    
    char* errInfo;
    
    int result = sqlite3_exec(_database, [query UTF8String], nil, nil, &errInfo);
    
    if (SQLITE_OK == result) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

- (BOOL) updateSource:(Source*)source {
    
    NSString *query = [NSString stringWithFormat: @"UPDATE Sources SET name = '%@', url = '%@', image = '%@', index_number = %ld, is_used = %d WHERE uid = '%@'", source.name, source.url, source.image, (long)source.index, source.isUsed, source.uid];
    
    char* errInfo;
    
    int result = sqlite3_exec(_database, [query UTF8String], nil, nil, &errInfo);
    
    if (SQLITE_OK == result) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

- (BOOL) deleteSource:(Source*)source {
    
    NSString *query = [NSString stringWithFormat: @"DELETE FROM Sources WHERE uid = '%@'", source.uid];
    
    char* errInfo;
    
    int result = sqlite3_exec(_database, [query UTF8String], nil, nil, &errInfo);
    
    if (SQLITE_OK == result) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}


#pragma mark - Favorites CRUD


- (NSArray*) getFavorites {
    return [[NSArray alloc]init];
}

- (BOOL) addFavorite:(Rss*)rss {
    return TRUE;
}

- (BOOL) removeFavorite:(Rss*)rss {
    return FALSE;
}

- (void) dealloc {
    
    sqlite3_close(_database);
    
}

@end
