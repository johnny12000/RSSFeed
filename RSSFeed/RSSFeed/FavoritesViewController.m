//
//  SecondViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@property NSArray* favorites;
@property RssRepository* repository;


@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(self.repository == nil)
        self.repository = [[RssRepository alloc] init];
    
    
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
    self.favorites = [self.repository getFavorites];
    
    [self.favoritesTableView reloadData];
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Rss* rss = [self.favorites objectAtIndex:indexPath.row];
    
    cell.textLabel.text = rss.title;
    
    UIImage* image = [UIImage imageWithData:rss.image];
    cell.imageView.image  = image;
    
    return cell;
}


@end
