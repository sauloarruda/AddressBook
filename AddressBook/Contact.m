//
//  Contact.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "Contact.h"
#import "ObjectManager.h"

@implementation Contact

@dynamic firstName;
@dynamic lastName;
@dynamic city;

- (NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (void)save
{
    [[ObjectManager sharedInstance] saveContext];
}

@end

static AddressBook* __sharedInstance;

@implementation AddressBook

+ (AddressBook*)sharedInstance
{
    if (!__sharedInstance) __sharedInstance = [[AddressBook alloc] init];
    return __sharedInstance;
}

- (NSArray*)allContacts
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Contact class])];
    NSManagedObjectContext* context = [ObjectManager sharedInstance].managedObjectContext;
    NSSortDescriptor* orderByName = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:orderByName]];
    
    NSError* error;
    NSArray* contactsArray = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error loading contacts: %@", error);
    }

    return contactsArray;
}

- (Contact*)newContact
{
    NSManagedObjectContext* context = [ObjectManager sharedInstance].managedObjectContext;
    Contact *contact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:context];
    return contact;
}

- (void)deleteContact:(Contact*)contact
{
    NSManagedObjectContext* context = [ObjectManager sharedInstance].managedObjectContext;
    [context deleteObject:contact];
    [[ObjectManager sharedInstance] saveContext];
}

@end
