//
//  ChecklistViewController.m
//  Checklists
//
//  Created by Russ D on 1/26/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"
@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

@synthesize checklist;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.checklist.name;
    
   // NSLog(@"Documents folder is %@", [self documentsDirectory]);
 //   NSLog(@"Data file path is %@", [self dataFilePath]);
    /*
    items = [[NSMutableArray alloc] initWithCapacity:20];
    
    ChecklistItem *item;
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Walk the dog";
    item.checked = YES;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Brush my teeth";
    item.checked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Learn IOS Development";
    item.checked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Soccer practice";
    item.checked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Ride Mountain Bike";
    item.checked = NO;s
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Eat Ice cream";
    item.checked = NO;
    [items addObject:item];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(bool)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
{
    return(interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checklist.items count];
}


-(void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if(item.checked)
    {
        label.text = @"√";
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {   label.text = @"";
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *) item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    ChecklistItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    //[self saveCheckListItems];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ChecklistItem  *item = [self.checklist.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}

-(IBAction)addItem
{
    //SET VARIABLE TO ARRAY LENGTH
    int newRowIndex = [self.checklist.items count];
    
    //ADD NEW ITEM TO ARRAY
    ChecklistItem *item =[[ChecklistItem alloc] init];
    item.text = @"I am a new row!";
    item.checked = NO;
    [self.checklist.items addObject:item];
    
    //TELL TABLE VIEW TO INSERT NEW DATA AT END OF LIST
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DELETE DATA FROM MODEL
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    
   // [self saveCheckListItems];
    //THEN DELETE FROM TABLE VIEW
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    int newRowIndex = [self.checklist.items count];
    [self.checklist.items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
   // [self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
    int index = [self.checklist.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
   // [self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController   *controller = (ItemDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
        controller.itemToEdit = sender;
    }
}


@end



