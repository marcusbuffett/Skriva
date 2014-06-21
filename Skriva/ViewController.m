//
//  ViewController.m
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 
            

@end

@implementation ViewController
@synthesize tableView, addButton;
- (void)viewDidLoad {
    [MKiCloudSync start];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width, 80)];
    addButton.backgroundColor = [UIColor colorWithWhite:0.168f alpha:1.0f];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-UltraLight" size:94];
    addButton.titleLabel.textColor = [UIColor colorWithWhite:0.91f alpha:1.0f];
    [addButton addTarget:self action:@selector(newNote) forControlEvents:UIControlEventTouchUpInside];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20-80)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView reloadData];
    [self.view addSubview:tableView];
    tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:addButton];
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


-(void)newNote
{
    NoteViewController* noteVC = [[NoteViewController alloc] init];
    noteVC.noteIndex = -1;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [self.navigationController pushViewController:noteVC animated:YES];
//                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//                     }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* notes = [self getNotes];
    if (indexPath.row == notes.count)
    {
        FooterCell* cell = [[FooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FOOTER"];
        return cell;
    }
    
    
    Note* noteForCell = [notes objectAtIndex:indexPath.row];
    CustomCell* cell = [[CustomCell alloc] initWithNote:noteForCell];
//    cell.backgroundColor = [UIColor colorWithWhite:.82 alpha:1.0];
    return cell;
}
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray* notes = [self getNotes];
        NSMutableArray* notesMutable = [notes mutableCopy];
        [notesMutable removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:notesMutable] forKey:@"notes"];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self getNotes].count)
    {
        return;
    }
    NoteViewController* noteVC = [[NoteViewController alloc] init];
    noteVC.noteIndex = indexPath.row;
    [self.navigationController pushViewController:noteVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* notes = [self getNotes];
    return notes.count + 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSArray *)getNotes
{
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"notes"];
    if (![dataRepresentingSavedArray isEqual:nil])
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        NSLog(@"Old saved array : %@", oldSavedArray);
        if (oldSavedArray == nil)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[[NSMutableArray alloc] init]] forKey:@"notes"];
            return [[NSMutableArray alloc] init];
        }
        else
        {
            return oldSavedArray;
        }
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[[NSMutableArray alloc] init]] forKey:@"notes"];
        return [[NSMutableArray alloc] init];
    }
}



@end
