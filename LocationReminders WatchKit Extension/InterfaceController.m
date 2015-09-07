//
//  InterfaceController.m
//  LocationReminders WatchKit Extension
//
//  Created by Kristen Kozmary on 9/4/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchKit/WatchKit.h>

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet InterfaceController *watchTable;
@property (strong, nonatomic) NSArray *array;
@end


@implementation InterfaceController



- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



