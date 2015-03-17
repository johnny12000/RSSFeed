//
//  ManagedRssRepository.m
//  RSSFeed
//
//  Created by nristic on 3/17/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "ManagedRssRepository.h"

@interface ManagedRssRepository ()

@end


@implementation ManagedRssRepository


static ManagedRssRepository* _instance;

+ (ManagedRssRepository*) instance {
    
    if(_instance == nil) {
        _instance = [[ManagedRssRepository alloc] init];
        
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _instance.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSURL* applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"Model.sqlite"];
        
        NSError *error = nil;
        _instance.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_instance.model];
        if (![_instance.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        _instance.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_instance.context setPersistentStoreCoordinator:_instance.coordinator];
    }
    
    return _instance;
}

- (Rss*) createFeed {
    Rss* rss = [NSEntityDescription insertNewObjectForEntityForName:@"Rss" inManagedObjectContext:self.context];
    return rss;
}

- (Rss*) getFeedByUrl:(NSString *)url {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Rss"
                                              inManagedObjectContext:self.context];
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"url=%@", url];
    fetchRequest.predicate=pred;
    
    NSError* error = nil;
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    
    return [fetchedObjects firstObject];
}

- (NSArray*) getFavorites {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Rss"
                                              inManagedObjectContext:self.context];
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"isFavorite=1"];
    fetchRequest.predicate=pred;
    
    NSError* error = nil;
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

- (Source*) createSource {
    Source* src = [NSEntityDescription insertNewObjectForEntityForName:@"Source" inManagedObjectContext:self.context];
    return src;
}

- (NSArray*) getSources {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Source"
                                              inManagedObjectContext:self.context];
    
    NSError* error = nil;
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

- (void) deleteObject:(NSManagedObject*)object {
    [self.context deleteObject:object];
}

- (BOOL) saveRepository:(NSError *__autoreleasing *)error {
    NSError* err = nil;
    
    [self.context save:&err];
    //error = err;
    return err == nil;
}

@end
