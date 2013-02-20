//
//  AllListsViewController.h
//  Checklists
//
//  Created by Russ D on 1/31/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;
//-(void)saveChecklists;

@end
