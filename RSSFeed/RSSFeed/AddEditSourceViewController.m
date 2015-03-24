//
//  AddEditSourceViewController.m
//  RSSFeed
//
//  Created by Nikola Ristic on 2/23/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import "AddEditSourceViewController.h"

@interface AddEditSourceViewController ()

@property Source* source;
@property RssReader* reader;
@property ManagedRssRepository* repository;

@end

@implementation AddEditSourceViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.reader = [[RssReader alloc] init];
        self.repository = [ManagedRssRepository instance];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sourceNameTextField.text = self.source ? self.source.name : @"";
    self.sourceUrlTextField.text =  self.source ? self.source.url : @"";
    
    [self setViewState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)sourceEdited:(id)sender {
    
    if(!self.source)
        self.source = [self.repository createSource];
        
    self.source.name = self.sourceNameTextField.text;
    self.source.url = self.sourceUrlTextField.text;
    self.source.isUsed = [NSNumber numberWithInteger:TRUE];
    
    [self.reader getImageDataFromUrl:self.source.url completionHandler:^(NSData* image, NSError* error){
        self.source.image = image;
        
        if(!self.source.uid) {
            self.source.uid = [[NSUUID UUID] UUIDString];
        }
        
        BOOL result;
        NSError* repoerror = nil;
        result = [self.repository saveRepository:&repoerror];
        
        [self notifySourceAddedOrChanged];
        
        if(result){
            //TODO: some message should be displayed
        }
        
        [self.navigationController popToRootViewControllerAnimated:TRUE];
        
    }];
}

- (IBAction)sourceCanceled:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    
}

- (IBAction)nameChanged:(id)sender {
    [self setViewState];
}

- (IBAction)linkChanged:(id)sender {
    [self setViewState];
}

- (void) notifySourceAddedOrChanged {
    
    NSNotification *notification = [NSNotification notificationWithName:NOTIFICATION_SOURCE_CHANGED object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

#pragma mark - Set Model

- (void) setModel:(Source*)source {
    self.source = source;
}

- (void) setNewModel
{
    //self.source = [[Source alloc]init];
}

#pragma mark - Set View State

- (void) setViewState{
    
    //TODO: check if name is uniqe
    BOOL isDataValid = [self.sourceUrlTextField.text isWebLink];
    
    [self.doneButton setEnabled: isDataValid];
}

@end
