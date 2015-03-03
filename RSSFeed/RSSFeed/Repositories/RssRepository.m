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
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT url, source, title, date, image, short_description, content, index_number FROM Favorites";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSString *url = [[NSString alloc] initWithUTF8String: (char*)sqlite3_column_text(statement, 0)];
            NSString *source = [[NSString alloc] initWithUTF8String: (char*)sqlite3_column_text(statement, 1)];
            NSString *title = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement, 2)];
            NSString *dateString = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement, 3)];
            
            NSString *imageB64 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement, 4)];
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageB64 options:0];
            NSString* shortDescription = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement, 5)];
            NSString* content = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement, 6)];
            int index = sqlite3_column_int(statement, 7);
            
            
            Rss* rss = [[Rss alloc] init];
            rss.url = url;
            rss.channel = source;
            rss.title = title;
            rss.image = imageData;
            rss.shortDescription = shortDescription;
            rss.content = content;
            
            [retval addObject:rss];
            
        }
        sqlite3_finalize(statement);
    }
    
    return retval;
}

- (BOOL) addFavorite:(Rss*)rss {
    
    //CREATE TABLE Favorites (url title, source text, title text, date text, image blob, short_description text, content blob, index_number integer);
    
    NSString* query = [NSString stringWithFormat: @"INSERT INTO Favorites (url, source, title, date, image, short_description, content, index_number) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', %d)", rss.url, rss.channel, rss.title, [self getUTCFormateDate:rss.date], [rss.image base64EncodedStringWithOptions:0], rss.shortDescription, rss.content, 0];
    
    char* errInfo;
    
    int result = sqlite3_exec(_database, [query UTF8String], nil, nil, &errInfo);
    
    if (SQLITE_OK == result) {
        return TRUE;
    }
    else {
        return FALSE;
    }

}

- (BOOL) removeFavorite:(Rss*)rss {
    return FALSE;
}

- (void) dealloc {
    
    sqlite3_close(_database);
    
}

- (NSString*) getUTCFormateDate:(NSDate *)localDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    
    return dateString;
}

@end
