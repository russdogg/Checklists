//
//  DataModel.m
//  Checklists
//
//  Created by Russ D on 2/14/13.
//  Copyright (c) 2013 Russ D. All rights reserved.
//
#import "Checklist.h"
#import "DataModel.h"


@implementation DataModel
@synthesize lists;

-(NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

-(NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Checklists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

-(void)loadChecklists
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
        [unarchiver finishDecoding];
    }
    else
    {
        self.lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

-(void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:-1], @"ChecklistIndex",
                                [NSNumber numberWithBool:YES], @"FirstTime",
                                nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    if(firstTime)
    {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = @"My First List";
        [self.lists addObject:checklist];
        [self setIndexOfSelectedChecklist:0];
        /*
        Checklist *checklist2 = [[Checklist alloc] init];
        checklist2.name = @"Second List";
        [self.lists addObject:checklist2];
        [self setIndexOfSelectedChecklist:1];*/
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
}

-(id)init
{
    if((self = [super init]))
    {
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}


-(int)indexOfSelectedChecklist
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

-(void)setIndexOfSelectedChecklist:(int)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

@end
