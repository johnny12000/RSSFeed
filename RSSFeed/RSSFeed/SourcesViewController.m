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
@property NSMutableArray* sources;

@end


@implementation SourcesViewController

@synthesize repository;
@synthesize sources;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.repository = [[RssRepository alloc] init];
    
    // Do any additional setup after loading the view.
    self.sourcesTable.delegate = self;
    self.sourcesTable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self refreshData];
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
    if(source.isUsed)
        [tableView selectRowAtIndexPath:indexPath
                               animated:YES
                         scrollPosition:UITableViewScrollPositionNone];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Source *object = (Source*)[self.sources objectAtIndex:indexPath.row];
        [self.sources removeObjectAtIndex:indexPath.row];
        BOOL result = [self.repository deleteSource:object];
        
        if(result)
        {
            //TODO: display error message
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)setSourceDelete:(id)sender {
    
    if ([self.sourcesTable isEditing]) {
        [self.sourcesTable setEditing:NO animated:YES];
        self.deleteButton.title = @"Delete";
    }
    else {
        [self.sourcesTable setEditing:YES animated:YES];
        self.deleteButton.title = @"Done";
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Source* source = [self.sources objectAtIndex:indexPath.row];
    source.isUsed = TRUE;
    [self.repository updateSource:source];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    Source* source = [self.sources objectAtIndex:indexPath.row];
    source.isUsed = FALSE;
    [self.repository updateSource:source];
}


#pragma mark - Actions

- (void) refreshData {
    
    self.sources = [[NSMutableArray alloc] initWithArray:[self.repository getSources]];
    [self.sourcesTable reloadData];
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"EditSourceSegue"])
    {
        AddEditSourceViewController *vc = [segue destinationViewController];
        [vc setModel: (Source*)[self.sources objectAtIndex:[self.sourcesTable indexPathForCell:sender].row]];
    }
    else if ([[segue identifier] isEqualToString:@"AddSourceSegue"])
    {
        AddEditSourceViewController *vc = [segue destinationViewController];
        [vc setNewModel];
    }
}

@end
