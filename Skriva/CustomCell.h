//
//  CustomCell.h
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface CustomCell : UITableViewCell

@property (nonatomic, retain) UILabel* noteText;
@property (nonatomic, retain) UILabel* date;
@property (nonatomic, retain) UILabel* time;
@property (nonatomic, retain) UIImageView* separator;

-(id)initWithNote:(Note*)n;

@end
