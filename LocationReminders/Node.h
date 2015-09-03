//
//  Node.h
//  LocationReminders
//
//  Created by Kristen Kozmary on 9/3/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (strong, nonatomic) id value;
@property (strong, nonatomic) Node *next;

@end
