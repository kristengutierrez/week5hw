//
//  SignInViewController.m
//  LocationReminders
//
//  Created by Kristen Kozmary on 9/3/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import "SignInViewController.h"
#import <Parse/Parse.h>


@interface SignInViewController ()

@end

@implementation SignInViewController


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if ([PFUser currentUser]) {
    self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser]username]];
  } else {
    self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
  }
}

//- (void)viewDidAppear:(BOOL)animated {
//  [super viewDidAppear:animated];
//  if (![PFUser currentUser]) {
//    PFLoginViewController *loginViewController = [[PFLoginViewController alloc] init]
//  }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signOut:(id)sender {
}
@end
