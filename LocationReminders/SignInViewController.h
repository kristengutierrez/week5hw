//
//  SignInViewController.h
//  LocationReminders
//
//  Created by Kristen Kozmary on 9/3/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignInViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;

- (IBAction)signOut:(id)sender;


@end
