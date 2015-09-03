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

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (copy, nonatomic) void(^myBlock)(NSString *);

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;

@end

@implementation ViewController



- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView.delegate = self;
  self.longPress.delegate = self;
  NSLog(@"%d", [CLLocationManager authorizationStatus]);
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager startUpdatingLocation];
  
  
  self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
  [self.mapView addGestureRecognizer:self.longPress];
  
}



- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(47.6235, -122.3363), 100, 100) animated:true];
  
  [UIView animateWithDuration:0.3 animations:^{
    
  }];
  
}
//Reminder *reminder = [Reminder object];
//reminder.name = @"Pizza";
//[reminder saveInBackground];
//PFQuery *pizzaQuery = [Reminder query];
//[pizzaQuery findObjectsInBackgroundWithBlock:^(NSArray *reminders, NSError *error) {
//  Reminder *firstReminder = [reminders firstObject];
//}];

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


   - (IBAction)vegasButtonPressed:(id)sender {
     [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(36.167501, -115.303923), 1000, 1000) animated:true];
//     MKPointAnnotation *annotation = CLLocationCoordinate2DMake(coordinates.latitude, coordinates.longitude);
//     annotation.title = @"Vegas House";
//     [self.mapView addAnnotation:annotation];

   }
   - (IBAction)sanDiegoButtonPressed:(id)sender {
     [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(32.9949497, -117.1895125), 1000, 1000) animated:true];
   }
   - (IBAction)dcButtonPressed:(id)sender {
     [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(38.9065382, -77.051096), 1000, 1000) animated:true];
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
