//
//  ViewController.m
//  LocationReminders
//
//  Created by Kristen Kozmary on 8/31/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "Reminder.h"
#import "Constants.h"
#import <ParseUI/ParseUI.h>

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate, PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (copy, nonatomic) void(^myBlock)(NSString *);

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) PFUser *user;

@end

@implementation ViewController



- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderNotification:) name:kReminderNotification object:nil];
  
  self.mapView.delegate = self;
  self.longPress.delegate = self;
  NSLog(@"%d", [CLLocationManager authorizationStatus]);
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager startUpdatingLocation];
  
  
  self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
  [self.mapView addGestureRecognizer:self.longPress];
  
//  [PFUser currentUser]
  
//  PFSignUpViewController *signUpVC = [[PFSignUpViewController alloc] init];
//  signUpVC.delegate = self;
//  [self presentViewController:signUpVC animated:true completion:nil];
  
  
  Reminder *reminder = [Reminder object];
  reminder.name = @"Reminder";
//  reminder.user = [PFUser currentUser];
  [reminder saveInBackground];
  
  PFQuery *pizzaQuery = [Reminder query];
  [pizzaQuery findObjectsInBackgroundWithBlock:^(NSArray *reminders, NSError *error) {
    
    Reminder *firstReminder = [reminders firstObject];
    NSLog(@"%@",firstReminder.name);
  }];
  
}

-(void)reminderNotification:(NSNotification *)notification {
  NSLog(@"notification fired!");
  NSDictionary *userInfo = notification.userInfo;
  if (userInfo) {
    
    NSString *value = userInfo[@"Yooooo"];
    
  }
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(47.6235, -122.3363), 100, 100) animated:true];
  
  [UIView animateWithDuration:0.3 animations:^{
    
  }];
  
  if (![PFUser currentUser]) { // No user logged in
    // Create the log in view controller
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
  }
  
}
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
  NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
  [self.navigationController popViewControllerAnimated:YES];
}


// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
  [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
  NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
  NSLog(@"User dismissed the signUpViewController");
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//Reminder *reminder = [Reminder object];
//reminder.name = @"Reminder";
//[reminder saveInBackground];
//PFQuery *pizzaQuery = [Reminder query];
//[pizzaQuery findObjectsInBackgroundWithBlock:^(NSArray *reminders, NSError *error) {
//  Reminder *firstReminder = [reminders firstObject];
//}];

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  switch (status) {
    case kCLAuthorizationStatusAuthorizedWhenInUse:
      [self.locationManager startUpdatingLocation];
      break;
      
    default:
      break;
  }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  CLLocation *location = locations.lastObject;
  NSLog(@"lat: %f, long: %f", location.coordinate.latitude, location.coordinate.longitude);
}


#pragma mark - MKMapViewDelegate




-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }

  MKPinAnnotationView *pinView =(MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"Annotation View"];
  if (!pinView) {
    pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotation View"];
  }
  pinView.animatesDrop = true;
  pinView.pinColor = MKPinAnnotationColorGreen;
  pinView.canShowCallout = true;
  
  UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
  pinView.rightCalloutAccessoryView = rightButton;
  return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

#pragma mark - UIGestureRecognizerDelegate
- (void)handleGestureRecognizer:(UILongPressGestureRecognizer *)sender {
  if (sender.state == UIGestureRecognizerStateEnded) {
  CGPoint touchLocation = [sender locationInView:self.mapView];
  CLLocationCoordinate2D coordinates = [self.mapView convertPoint:touchLocation toCoordinateFromView:self.mapView];
  NSLog(@"%f, %f", coordinates.latitude, coordinates.longitude);
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  annotation.coordinate = CLLocationCoordinate2DMake(coordinates.latitude, coordinates.longitude);
  annotation.title = @"My Favorite Place";
  [self.mapView addAnnotation:annotation];
  }
}

@end
