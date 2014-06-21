//
//  FooterCell.m
//  Skriva
//
//  Created by Marcus Buffett on 6/6/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import "FooterCell.h"

@implementation FooterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel* skrivaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        skrivaLabel.textAlignment = NSTextAlignmentCenter;
        skrivaLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48];
        skrivaLabel.textColor = [UIColor colorWithWhite:.6 alpha:1.0];
        skrivaLabel.text = @"Skriva";
        [self addSubview:skrivaLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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

@end
