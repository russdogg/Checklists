//
//  Checklist.h
//  Checklists
//
//  Created by Russ D on 2/2/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>


@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *name;

-(int)countUncheckedItems;


@end
