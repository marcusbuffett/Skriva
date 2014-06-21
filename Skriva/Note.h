//
//  Note.h
//  Skriva
//
//  Created by Marcus Buffett on 6/5/14.
//  Copyright (c) 2014 Marcus Buffett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (nonatomic, retain) NSString* noteText;
@property (nonatomic, retain) NSDate* date;

-(id)initWithNote:(NSString*)s date:(NSDate*)d;

@end
