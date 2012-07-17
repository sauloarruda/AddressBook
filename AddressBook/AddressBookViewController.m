//
//  AddressBookViewController.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "AddressBookViewController.h"
#import "ContactDetailViewController.h"
#import "Contact.h"

@interface AddressBookViewController () {
    BOOL _editing;
}

@property (nonatomic, strong) NSMutableArray* contactsArray;
- (IBAction)editButtonTapped:(id)sender;

@end

@implementation AddressBookViewController

@synthesize contactsArray = _contactsArray;

//- (NSArray*)contactsArray
//{
//    if (!_contactsArray) {
//        _contactsArray = [[AddressBook sharedInstance] allContacts];
//    }
//    return _contactsArray;
//}

- (void)viewDidAppear:(BOOL)animated
{
    self.contactsArray = [[[AddressBook sharedInstance] allContacts] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactsArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"contactCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // Configurar célula
    Contact* contact = [self.contactsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:contact.fullName];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact* contact = [self.contactsArray objectAtIndex:indexPath.row];
    ContactDetailViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"contactDetail"];
    [controller setContact:contact];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact* contact = [self.contactsArray objectAtIndex:indexPath.row];
    [[AddressBook sharedInstance] deleteContact:contact];
    [self.contactsArray removeObject:contact];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Actions

- (IBAction)editButtonTapped:(id)sender {
    _editing = !_editing;
    [self.tableView setEditing:_editing];
}
@end
