//
//  SecondViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@property NSMutableArray* favorites;
@property ManagedRssRepository* repository;
@property NSArray* sources;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(self.repository == nil)
        self.repository = [ManagedRssRepository instance];
    
    UINib *nib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.favoritesTableView registerNib:nib forCellReuseIdentifier:@"FeedCell"];
    
    self.favoritesTableView.dataSource = self;
    self.favoritesTableView.delegate = self;
    
    [self reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data

- (void) reloadData {
    self.favorites = [NSMutableArray arrayWithArray: [self.repository getFavorites]];
    self.sources = [self.repository getSources];
    
    [self.favoritesTableView reloadData];
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FeedCell";
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Rss* rss = [self.favorites objectAtIndex:indexPath.row];
    
    NSPredicate* srcPredicate = [NSPredicate predicateWithFormat:@"url = %@", rss.channel];
    
    Source* source = [[self.sources filteredArrayUsingPredicate:srcPredicate] firstObject];
    
    [cell setCellModel:rss andSource:source index:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"FeedDetailSegue" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Rss* object = (Rss*)[self.favorites objectAtIndex:indexPath.row];
        object.isFavorite = [NSNumber numberWithBool:FALSE];
        
        [self.favorites removeObjectAtIndex:indexPath.row];
        
        NSError* error = nil;
        BOOL result = [self.repository saveRepository:&error];
        
        if(result)
        {
            //TODO: display error message
        }
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Action

- (IBAction)deleteClicked:(id)sender {
    
    self.favoritesTableView.editing = !self.favoritesTableView.editing;
    
    if(self.favoritesTableView.isEditing)
        self.deleteButton.title = NSLocalizedString(@"DONE", nil);
    else
        self.deleteButton.title = @"Delete";
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"FeedDetailSegue"])
    {
        FeedDetailsViewController *vc = [segue destinationViewController];
        
        Rss* rss = [self.favorites objectAtIndex:self.favoritesTableView.indexPathForSelectedRow.row];
        
        NSPredicate* srcPredicate = [NSPredicate predicateWithFormat:@"url = %@", rss.channel];
        
        Source* source = [[self.sources filteredArrayUsingPredicate:srcPredicate] firstObject];
        
        [vc setModel:rss withSource:source];
    }
}

@end
