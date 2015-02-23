//
//  AddEditSourceViewController.h
//  RSSFeed
//
//  Created by Nikola Ristic on 2/23/15.
//  Copyright (c) 2015 jhny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Source.h"
#import "RssRepository.h"

@interface AddEditSourceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *sourceNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sourceUrlTextField;

- (IBAction)sourceEdited:(id)sender;
- (IBAction)sourceCanceled:(id)sender;


- (void) setModel:(Source*)source;
- (void) setNewModel;

@end
