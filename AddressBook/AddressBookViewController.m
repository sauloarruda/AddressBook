//
//  AddressBookViewController.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "AddressBookViewController.h"
#import "Contact.h"

@interface AddressBookViewController () 

@property (nonatomic, strong) NSArray* contactsArray;

@end

@implementation AddressBookViewController

@synthesize contactsArray = _contactsArray;

- (NSArray*)contactsArray
{
    if (!_contactsArray) {
        _contactsArray = [[AddressBook sharedInstance] allContacts];
    }
    return _contactsArray;
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

@end
