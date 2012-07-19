//
//  ContactDetailViewController.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "ContactDetailViewController.h"

#define kCityRowIndex 2
#define kGenderRowIndex 3

@interface ContactDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
- (IBAction)doneButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPickerView;
@property (strong, nonatomic) NSArray* genderArray;

@end

@implementation ContactDetailViewController
@synthesize genderTextField;
@synthesize genderPickerView;
@synthesize cityTextField;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize contact;
@synthesize genderArray = _genderArray;

- (NSArray*)genderArray
{
    if (!_genderArray) _genderArray = [NSArray arrayWithObjects:@"-", @"Male", @"Female", nil];
    return _genderArray;
}

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
    [self setGenderTextField:nil];
    [self setGenderPickerView:nil];
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
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.genderPickerView setHidden:YES];
    if (indexPath.row == kCityRowIndex) {
//        CityViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cityList"];
//        [self.navigationController pushViewController:controller animated:YES];
        [self performSegueWithIdentifier:@"selectCity" sender:self];
    }
    else if (indexPath.row == kGenderRowIndex) {
        [self.genderPickerView setHidden:NO];
    }
}

#pragma mark - UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.genderArray count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.genderArray objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.genderTextField setText:[self.genderArray objectAtIndex:row]];
    [self.genderPickerView setHidden:YES];
}

#pragma mark - CityViewControllerDelegate methods

- (void)didSelectCity:(City *)city
{
    [self.contact setCity:city];
    [self.cityTextField setText:city.name];
}

@end
