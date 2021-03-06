//
//  ChecklistItem.m
//  Checklists
//
//  Created by Russ D on 1/27/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import "DataModel.h"
#import "ChecklistItem.h"

@implementation ChecklistItem

@synthesize text, checked, dueDate, shouldRemind, itemId;

-(id)init
{
    if (self = [super init])
    {
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntForKey:@"ItemID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemID"];
}

- (void)scheduleNotification
{
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending)
    {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init ];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone]; localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName; localNotification.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        
        [[UIApplication sharedApplication] scheduleLocalNotification: localNotification];
        NSLog(@"Scheduled notification %@ for itemId %d", localNotification, self.itemId);
    }
}

- (void)toggleChecked
{
    self.checked = !self.checked;
}

@end
