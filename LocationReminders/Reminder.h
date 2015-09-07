//
//  Reminder.h
//  LocationReminders
//
//  Created by Kristen Kozmary on 9/2/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>
//should correspond with columns on Parse
@property (strong, nonatomic) NSString *name;
@property (strong,nonatomic) PFUser *user;

@end
