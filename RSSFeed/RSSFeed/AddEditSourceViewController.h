//
//  AddEditSourceViewController.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/23/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Source.h"
#import "ManagedRssRepository.h"
#import "RssReader.h"
#import "NSString+Validation.h"
#import "Constants.h"

@interface AddEditSourceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *sourceNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sourceUrlTextField;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)sourceEdited:(id)sender;
- (IBAction)sourceCanceled:(id)sender;


- (IBAction)nameChanged:(id)sender;
- (IBAction)linkChanged:(id)sender;


- (void) setModel:(Source*)source;
- (void) setNewModel;

@end
