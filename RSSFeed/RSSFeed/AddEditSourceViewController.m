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

@end

@implementation AddEditSourceViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.reader = [[RssReader alloc] init];
    }
    return self;
}


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
    self.source.isUsed = [NSNumber numberWithInteger:TRUE];
    
    [self.reader getImageDataFromUrl:self.source.url completionHandler:^(NSData* image, NSError* error){
        self.source.image = image;
        
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
    
    //TODO: check if name is uniqe
    BOOL isDataValid = [self.sourceUrlTextField.text isWebLink];
    
    [self.doneButton setEnabled: isDataValid];
}

@end
