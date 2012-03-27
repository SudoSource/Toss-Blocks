//
//  cpCCSpriteTB.m
//  Toss Blocks
//
//  Created by Connor on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cpCCSpriteTB.h"


@implementation cpCCSpriteTB
@synthesize mainblock, type, samecolor, scarray, number, blockActive, blockColor, difficulty, isMoving;

+ (id) spriteWithShape:(cpShape *)shape difficulty:(int)diff {
		return [[[self alloc] initWithShape:shape difficulty:diff] autorelease];
}

- (id) initWithShape:(cpShape*)shape difficulty:(int)diff
{
	difficulty = diff;
	blockActive = YES;
	scarray = [[NSMutableArray alloc] init];
	if (difficulty == 1) {
		type = 1 + arc4random() % 3;
		if (type == 1) {
			[super initWithFile:@"Blueblock.png"];
            blockColor = @"Blue";
		}else if (type == 2) {
			[super initWithFile:@"Redblock.png"];
            blockColor = @"Red";
		}else if (type == 3) {
			[super initWithFile:@"Greenblock.png"];
            blockColor = @"Green";
		}
	}else if (difficulty == 2) {
		type = 1 + arc4random() % 4;
		if (type == 1) {
			[super initWithFile:@"Blueblock.png"];
            blockColor = @"Blue";
		}else if (type == 2) {
			[super initWithFile:@"Redblock.png"];
            blockColor = @"Red";
		}else if (type == 3) {
			[super initWithFile:@"Greenblock.png"];
            blockColor = @"Green";
		}else if (type == 4) {
			[super initWithFile:@"Purpleblock.png"];
            blockColor = @"Purple";
		}
	}else if (difficulty == 3) {
		type = 1 + arc4random() % 5;
		if (type == 1) {
			[super initWithFile:@"Blueblock.png"];
            blockColor = @"Blue";
		}else if (type == 2) {
			[super initWithFile:@"Redblock.png"];
            blockColor = @"Red";
		}else if (type == 3) {
			[super initWithFile:@"Greenblock.png"];
            blockColor = @"Green";
		}else if (type == 4) {
			[super initWithFile:@"Purpleblock.png"];
            blockColor = @"Purple";
		}else if (type == 5) {
			[super initWithFile:@"Whiteblock.png"];
            blockColor = @"White";
		}
	}else if (difficulty == 4) {
		type = 1 + arc4random() % 6;
		if (type == 1) {
			[super initWithFile:@"Blueblock.png"];
            blockColor = @"Blue";
		}else if (type == 2) {
			[super initWithFile:@"Redblock.png"];
            blockColor = @"Red";
		}else if (type == 3) {
			[super initWithFile:@"Greenblock.png"];
            blockColor = @"Green";
		}else if (type == 4) {
			[super initWithFile:@"Purpleblock.png"];
            blockColor = @"Purple";
		}else if (type == 5) {
			[super initWithFile:@"Whiteblock.png"];
            blockColor = @"White";
		}else if (type == 6) {
			[super initWithFile:@"Greyblock.png"];
            blockColor = @"Grey";
		}
	}else if (difficulty == 5) {
		type = 1 + arc4random() % 7;
		if (type == 1) {
			[super initWithFile:@"Blueblock.png"];
            blockColor = @"Blue";
		}else if (type == 2) {
			[super initWithFile:@"Redblock.png"];
            blockColor = @"Red";
		}else if (type == 3) {
			[super initWithFile:@"Greenblock.png"];
            blockColor = @"Green";
		}else if (type == 4) {
			[super initWithFile:@"Purpleblock.png"];
            blockColor = @"Purple";
		}else if (type == 5) {
			[super initWithFile:@"Whiteblock.png"];
            blockColor = @"White";
		}else if (type == 6) {
			[super initWithFile:@"Greyblock.png"];
            blockColor = @"Grey";
		}else if (type == 7) {
			[super initWithFile:@"Yellowblock.png"];
            blockColor = @"Yellow";
		}
	}
	
	
		
	CPCCNODE_MEM_VARS_INIT(shape)
	
	return self;
}

- (void) dealloc {
    [super dealloc];
}

@end
