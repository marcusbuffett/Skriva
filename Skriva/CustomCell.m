//
//  CustomCell.m
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize noteText, date, time, separator;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

-(id)initWithNote:(Note *)n
{
    self = [super init];
    
    NSDate* d = n.date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    noteText = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 64)];
    noteText.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
    noteText.minimumScaleFactor = 0.7;
    noteText.adjustsFontSizeToFitWidth = true;
    noteText.textColor = [UIColor colorWithWhite:0.168f alpha:1.0f];
    noteText.textAlignment = NSTextAlignmentLeft;
    noteText.text = n.noteText;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    [self.contentView addSubview:noteText];
    
    date = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 14, 100, 18)];
    date.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    date.textColor = [UIColor colorWithWhite:0.168f alpha:1.0f];
    date.textAlignment = NSTextAlignmentCenter;
    [formatter setDateFormat:@"MMMM dd"];
    date.text = [formatter stringFromDate:d];
    [self.contentView addSubview:date];
    
    time = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 36, 100, 14)];
    time.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:12];
    time.textColor = [UIColor colorWithWhite:0.168f alpha:1.0f];
    time.textAlignment = NSTextAlignmentCenter;
    [formatter setDateFormat:@"h:mm a"];
    time.text = [formatter stringFromDate:d];
    [self.contentView addSubview:time];
    
    separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator"]];
    separator.frame = CGRectMake(0, 64-1, 320, 1);
    [self addSubview:separator];
    
    return self;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here to do what you want when you hit delete
//        [itemArray removeObjectAtIndex:[indexPath row]];
//        [tableView reloadData];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}



@end
