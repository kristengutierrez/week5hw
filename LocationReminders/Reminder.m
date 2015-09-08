//
//  Reminder.m
//  LocationReminders
//
//  Created by Kristen Kozmary on 9/2/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import "Reminder.h"

@interface Reminder ()

@end

@implementation Reminder
//return the name of the class you want to correspond with
+ (NSString * __nonnull)parseClassName {
  return @"Reminder";
}

@dynamic name;
@dynamic user;
@dynamic coordinates;
@dynamic radius;

@end
