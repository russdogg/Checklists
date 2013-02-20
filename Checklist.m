//
//  Checklist.m
//  Checklists
//
//  Created by Russ D on 2/2/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import "ChecklistItem.h"
#import "Checklist.h"

@implementation Checklist
@synthesize name;
@synthesize items;

-(id)init
{
    if ((self = [super init]))
    {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}

-(int)countUncheckedItems
{
    int count=0;
    for(ChecklistItem *item in self.items)
    {
        if(!item.checked)
        {
            count += 1;
        }
    }
    return count;
    
}

@end
