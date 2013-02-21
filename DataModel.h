//
//  DataModel.h
//  Checklists
//
//  Created by Russ D on 2/14/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)saveChecklists;
- (int)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(int)index;
- (void)sortChecklists;

@end
