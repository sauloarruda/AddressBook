//
//  ContactDetailViewController.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "ContactDetailViewController.h"

#define kCityRowIndex 2

@interface ContactDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
- (IBAction)doneButtonTapped:(id)sender;

@end

@implementation ContactDetailViewController
@synthesize cityTextField;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize contact;

- (void)viewDidLoad
{
    if (self.contact) {
        [self.firstNameTextField setText:self.contact.firstName];
        [self.lastNameTextField setText:self.contact.lastName];
        [self.cityTextField setText:self.contact.city.name];
    } else {
        self.contact = [[AddressBook sharedInstance] newContact];
    }
}
- (void)viewDidUnload {
    [self setFirstNameTextField:nil];
    [self setLastNameTextField:nil];
    [self setCityTextField:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectCity"]) {
        CityViewController* controller = segue.destinationViewController;
        [controller setDelegate:self];
        [controller setCity:self.contact.city];
    }
}

#pragma mark - Actions

- (IBAction)doneButtonTapped:(id)sender {
    [self.contact setFirstName:self.firstNameTextField.text];
    [self.contact setLastName:self.lastNameTextField.text];
    [self.contact save];   
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISplitViewDelegate methods

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kCityRowIndex) {
//        CityViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cityList"];
//        [self.navigationController pushViewController:controller animated:YES];
        [self performSegueWithIdentifier:@"selectCity" sender:self];
    }
}

#pragma mark = CityViewControllerDelegate methods

- (void)didSelectCity:(City *)city
{
    [self.contact setCity:city];
    [self.cityTextField setText:city.name];
}

@end
