//
//  Contact.h
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

#pragma mark - Transient properties
@property (nonatomic, readonly) NSString* fullName;

- (void)save;

@end

@interface AddressBook : NSObject

+ (AddressBook*)sharedInstance;

- (NSArray*)allContacts;
- (Contact*)newContact;
- (void)deleteContact:(Contact*)contact;

@end
