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

@end

@implementation AddEditSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sourceNameTextField.text = self.source.name;
    self.sourceUrlTextField.text = self.source.url;
    
    [self setViewState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)sourceEdited:(id)sender {
    
    self.source.name = self.sourceNameTextField.text;
    self.source.url = self.sourceUrlTextField.text;
    
    
    BOOL result;
    
    if(self.source.uid)
        result = [[RssRepository instance] updateSource:self.source];
    else{
        self.source.uid = [[NSUUID UUID] UUIDString];
        result = [[RssRepository instance] addSource:self.source];
    }
    
    if(result){
        //TODO: some message should be displayed
    }
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    
}

- (IBAction)sourceCanceled:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    
}

- (IBAction)nameChanged:(id)sender {
    //TODO: check if name is uniqe
    
}

- (IBAction)linkChanged:(id)sender {
    
    [self setViewState];
}

#pragma mark - Set Model

- (void) setModel:(Source*)source {
    self.source = source;
}

- (void) setNewModel
{
    self.source = [[Source alloc]init];
}

#pragma mark - Set View State

- (void) setViewState{
    
    BOOL isDataValid = [self.sourceUrlTextField.text isWebLink];
    
    [self.doneButton setEnabled: isDataValid];
}

@end
