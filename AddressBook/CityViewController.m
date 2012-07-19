//
//  CityViewController.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/18/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()

@property (nonatomic, strong) NSArray* citiesArray;

@end

@implementation CityViewController

@synthesize delegate = _delegate;
@synthesize city = _city;
@synthesize citiesArray = _citiesArray;

- (void)viewDidLoad
{
    self.citiesArray = [City allCities];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.citiesArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    City* city = [self.citiesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.state;
    if ([self.city isEqual:city]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City* city = [self.citiesArray objectAtIndex:indexPath.row];
    [self.delegate didSelectCity:city];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
