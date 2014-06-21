//
//  Note.m
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import "Note.h"

@implementation Note
@synthesize noteText, date;


-(id)initWithNote:(NSString *)s date:(NSDate *)d
{
    noteText = s;
    date = d;
    return self;
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        noteText = [coder decodeObjectForKey:@"noteText"];
        date = [coder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:noteText forKey:@"noteText"];
    [coder encodeObject:date forKey:@"date"];
}


@end
