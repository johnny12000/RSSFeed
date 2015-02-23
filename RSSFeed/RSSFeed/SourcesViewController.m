//
//  SourcesViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/1/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "SourcesViewController.h"
#import "Repositories/RssRepository.h"
#import "Source.h"

@interface SourcesViewController ()

@property RssRepository* repository;
@property NSArray* sources;

@end


@implementation SourcesViewController

@synthesize repository;
@synthesize sources;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.repository = [[RssRepository alloc] init];
    
    self.sources = [self.repository getSources];
    
    // Do any additional setup after loading the view.
    self.sourcesTable.delegate = self;
    self.sourcesTable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView elements

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sources.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"SourceCell";
    
    UITableViewCell *cell = [self.sourcesTable dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Source* source = (Source*)[self.sources objectAtIndex:indexPath.row];
    
    cell.textLabel.text = source.name;
    
    return cell;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
