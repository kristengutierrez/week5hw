//
//  DetailViewController.m
//  LocationReminders
//
//  Created by Kristen Kozmary on 9/2/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import "AddReminderDetailViewController.h"
#import "Constants.h"
#import "Reminder.h"

@interface AddReminderDetailViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *descriptionLabel;
@property int sliderStuff;
@end

@implementation AddReminderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  _sliderStuff = 125;
  
}

- (IBAction)saveButtonPressed:(id)sender {
  UILocalNotification *notification = [[UILocalNotification alloc] init];
  
  notification.alertTitle = @"Notification";
  notification.alertBody = @"Saved Location";
  Reminder *info = [[Reminder alloc] init];
  info.radius = self.slider.value;
//  info.coordinates =
  
  
  [[UIApplication sharedApplication] scheduleLocalNotification:notification];
  
  
//  
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"myReminderInfo" forKey:@"Hello"];
//  NSDictionary *otherUserInfo = [[NSDictionary alloc] init];

  
  [[NSNotificationCenter defaultCenter] postNotificationName:kReminderNotification object:self userInfo:userInfo];
    [self.navigationController popToRootViewControllerAnimated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderValueChanged:(id)sender {
  
  self.label.text = [NSString stringWithFormat:@"%.0f", self.slider.value];
  _slider.maximumValue = 250;
  _slider.minimumValue = 1;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
