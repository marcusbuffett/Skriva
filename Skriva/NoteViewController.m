//
//  NoteViewController.m
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

@synthesize textView, noteIndex, saveNote, deleteNote, backgroundConfirm;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [textView becomeFirstResponder];
    
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)textViewDidChange:(UITextView *)t
{
    if ([t.text hasSuffix:@"\n"]) {
        
        [CATransaction setCompletionBlock:^{
            [self scrollToCaretInTextView:textView animated:NO];
        }];
        
    } else {
        [self scrollToCaretInTextView:textView animated:NO];
    }
}

- (void)scrollToCaretInTextView:(UITextView *)t animated:(BOOL)animated
{
    CGRect rect = [t caretRectForPosition:t.selectedTextRange.end];
    rect.size.height += t.textContainerInset.bottom;
    [t scrollRectToVisible:rect animated:animated];
}

- (void)keyboardIsUp:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets inset = self.textView.contentInset;
    inset.bottom = keyboardRect.size.height;
    self.textView.contentInset = inset;
    self.textView.scrollIndicatorInsets = inset;
    
    [self scrollToCaretInTextView:self.textView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    textView = [[UITextView alloc] initWithFrame:CGRectMake(4, 40, 312, self.view.frame.size.height-50-10)];
    textView.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    textView.textColor = [UIColor colorWithWhite:.2 alpha:1.0];
    textView.delegate = self;
    [[UITextView appearance] setTintColor:[UIColor lightGrayColor]];
    if (noteIndex >= 0)
    {
        NSArray* notes = [self getNotes];
        Note* note = [notes objectAtIndex:noteIndex];
        textView.text = note.noteText;
    }
    [self.view addSubview:textView];
    
    saveNote = [[UIButton alloc] initWithFrame:CGRectMake(160, 20, 160, 40)];
    [saveNote setImage:[UIImage imageNamed:@"save_note"] forState:UIControlStateNormal];
    [saveNote addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveNote];
    
    deleteNote = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 160, 40)];
    [deleteNote setImage:[UIImage imageNamed:@"delete_note"] forState:UIControlStateNormal];
    [deleteNote addTarget:self action:@selector(confirmDelete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteNote];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsUp:) name:UIKeyboardDidShowNotification object:nil];
    UIView* statusBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBarBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0f];
    [self.view addSubview:statusBarBackground];
}

-(void)confirmDelete
{
    [textView resignFirstResponder];
    int backgroundConfirmWidth = 194;
    int backgroundConfirmHeight = 202;
    CGFloat borderWidth = 1.0f;
    CGFloat textPadding = 5.0f;
    int buttonsHeight = 44;
    int buttonsWidth = 96;
    
    backgroundConfirm = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-backgroundConfirmWidth/2, self.view.frame.size.height/2-backgroundConfirmHeight/2, backgroundConfirmWidth, backgroundConfirmHeight)];
    backgroundConfirm.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    backgroundConfirm.layer.borderWidth = borderWidth;
    backgroundConfirm.layer.borderColor = [UIColor blackColor].CGColor;
    
    UILabel* confirmText = [[UILabel alloc] initWithFrame:CGRectMake(borderWidth+textPadding, borderWidth+textPadding, backgroundConfirmWidth-borderWidth*2-textPadding*2, backgroundConfirmHeight-borderWidth*2-textPadding*2-buttonsHeight)];
    confirmText.numberOfLines = 0;
    confirmText.text = @"Are you sure you want to delete this note?";
    confirmText.font = [UIFont fontWithName:@"AvenirNext-Regular" size:25.0f];
    confirmText.textColor = [UIColor blackColor];
    confirmText.textAlignment = NSTextAlignmentCenter;
    [backgroundConfirm addSubview:confirmText];
    
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(borderWidth, backgroundConfirmHeight-borderWidth-buttonsHeight, buttonsWidth, buttonsHeight);
    [cancelButton addTarget:self action:@selector(dismissConfirm) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setImage:[UIImage imageNamed:@"delete_confirm_cancel_button"] forState:UIControlStateNormal];
    [backgroundConfirm addSubview:cancelButton];
    
    UIButton* deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(borderWidth+buttonsWidth, backgroundConfirmHeight-borderWidth-buttonsHeight, buttonsWidth, buttonsHeight);
    [deleteButton addTarget:self action:@selector(deleteN) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setImage:[UIImage imageNamed:@"delete_confirm_delete_button"] forState:UIControlStateNormal];
    [backgroundConfirm addSubview:deleteButton];
    
    [self.view addSubview:backgroundConfirm];
}

-(void)dismissConfirm
{
    [backgroundConfirm removeFromSuperview];
}

-(void)save
{
    if ([textView.text isEqualToString:@""] || [textView.text isEqual:nil])
    {
        [self.view endEditing:YES];
        [self.navigationController popToRootViewControllerAnimated:true];
        return;
    }
    if (noteIndex == -1)
    {
        Note* note = [[Note alloc] initWithNote:textView.text date:[NSDate date]];
        NSArray* notes = [self getNotes];
        NSMutableArray* mutableNotes = [notes mutableCopy];
        [mutableNotes insertObject:note atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:mutableNotes] forKey:@"notes"];
        [self.view endEditing:YES];
        [self.navigationController popToRootViewControllerAnimated:true];
    }
    else
    {
        Note* note = [[Note alloc] initWithNote:textView.text date:[NSDate date]];
        NSArray* notes = [self getNotes];
        NSMutableArray* mutableNotes = [notes mutableCopy];
        [mutableNotes removeObjectAtIndex:noteIndex];
        [mutableNotes insertObject:note atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:mutableNotes] forKey:@"notes"];
        [self.view endEditing:YES];
        [self.navigationController popToRootViewControllerAnimated:true];
    }
    
}

-(void)deleteN
{
    if (noteIndex != -1)
    {
        NSArray* notes = [self getNotes];
        NSMutableArray* mutableNotes = [notes mutableCopy];
        [mutableNotes removeObjectAtIndex:noteIndex];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:mutableNotes] forKey:@"notes"];
        [self.view endEditing:YES];
        [self.navigationController popToRootViewControllerAnimated:true];
    }
    
    [self.view endEditing:YES];
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)getNotes
{
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"notes"];
    if (![dataRepresentingSavedArray isEqual:nil])
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if ([oldSavedArray isEqual:nil])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[[NSMutableArray alloc] init]] forKey:@"notes"];
        }
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[[NSMutableArray alloc] init]] forKey:@"notes"];
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"notes"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
