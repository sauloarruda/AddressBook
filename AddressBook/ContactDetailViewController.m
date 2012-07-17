//
//  ContactDetailViewController.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "ContactDetailViewController.h"

@interface ContactDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
- (IBAction)doneButtonTapped:(id)sender;

@end

@implementation ContactDetailViewController
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize contact;

- (void)viewDidLoad
{
    if (self.contact) {
        [self.firstNameTextField setText:self.contact.firstName];
        [self.lastNameTextField setText:self.contact.lastName];
    }
}
- (void)viewDidUnload {
    [self setFirstNameTextField:nil];
    [self setLastNameTextField:nil];
    [super viewDidUnload];
}

- (IBAction)doneButtonTapped:(id)sender {
    if (!self.contact)
        self.contact = [[AddressBook sharedInstance] newContact];
    [self.contact setFirstName:self.firstNameTextField.text];
    [self.contact setLastName:self.lastNameTextField.text];
    [self.contact save];    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
