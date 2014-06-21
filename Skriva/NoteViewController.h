//
//  NoteViewController.h
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface NoteViewController : UIViewController <UITextViewDelegate>

@property(nonatomic, retain) UITextView* textView;
@property(nonatomic, assign) int noteIndex;
@property(nonatomic, retain) UIButton* saveNote;
@property(nonatomic, retain) UIButton* deleteNote;

-(void)save;
-(void)deleteN;
-(NSArray*)getNotes;
- (void)scrollToCaretInTextView:(UITextView *)textView animated:(BOOL)animated;

@end
