//
//  City.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/18/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "City.h"
#import "Contact.h"
#import "ObjectManager.h"

@implementation City

@dynamic name;
@dynamic state;
@dynamic contacts;

+ (NSArray*)allCities 
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([City class])];
    NSSortDescriptor* orderByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:orderByName]];
    NSError* error;
    NSArray* cities = [[ObjectManager sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"Error: %@", error); 
    }
    return cities;
}

@end
