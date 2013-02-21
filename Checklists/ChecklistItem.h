//
//  ChecklistItem.h
//  Checklists
//
//  Created by Russ D on 1/27/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end

