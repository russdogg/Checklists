//
//  ChecklistViewController.h
//  Checklists
//
//  Created by Russ D on 1/26/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

-(IBAction)addItem;

@end
