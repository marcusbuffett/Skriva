//
//  ViewController.h
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteViewController.h"
#import "CustomCell.h"
#import "FooterCell.h"
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) UIButton* addButton;

- (void) newNote;

- (NSArray*) getNotes;
@end

