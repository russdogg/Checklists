//
//  ItemDetailViewController.m
//  Checklists
//
//  Created by Russ D on 1/27/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"


@interface ItemDetailViewController ()
@end

@implementation ItemDetailViewController

@synthesize delegate;
@synthesize itemToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.itemToEdit != nil)
    {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//CANCEL & DONE FUNCTIONS
-(IBAction)cancel
{
    [self.delegate itemDetailViewControllerDidCancel:self];
}

-(IBAction)done
{
    if(self.itemToEdit == nil)
    {
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text   = self.textField.text;
        item.checked = NO;
    
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    else
    {
        self.itemToEdit.text = self.textField.text;
        
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
    
    
    
}

//DISABLE BLUE HIGHLIGHT FOR CELL
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [super viewDidUnload];
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
    
    /*if([newText length] >0)
    {
        self.doneBarButton.enabled = YES;
    }
    else
    {
        self.doneBarButton.enabled = NO;
    }
    return YES;*/
}

@end
