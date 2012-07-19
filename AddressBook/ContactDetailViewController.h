//
//  ContactDetailViewController.h
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "CityViewController.h"

@interface ContactDetailViewController : UITableViewController<UISplitViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, CityViewControllerDelegate>

@property (nonatomic, weak) Contact* contact;

@end
