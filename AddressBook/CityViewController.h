//
//  CityViewController.h
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/18/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol CityViewControllerDelegate <NSObject>

- (void)didSelectCity:(City*)city;

@end

@interface CityViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<CityViewControllerDelegate> delegate;
@property (nonatomic, weak) City* city;

@end
