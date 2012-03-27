//
//  cpCCSpriteTB.h
//  Toss Blocks
//
//  Created by Connor on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceManagerCocos2d.h"

@interface cpCCSpriteTB : cpCCSprite {
	int difficulty;
    NSString *blockColor;
	BOOL mainblock;
	BOOL blockActive;
    BOOL isMoving;
	int type;
	int samecolor;
	int number;
	NSMutableArray *scarray;
}
@property(nonatomic, retain) NSString *blockColor;
@property(nonatomic)BOOL mainblock;
@property(nonatomic)BOOL blockActive;
@property(nonatomic)BOOL isMoving;
@property(nonatomic)int type;
@property(nonatomic)int samecolor;
@property(nonatomic)int number;
@property(nonatomic)int difficulty;
@property(nonatomic, retain)NSMutableArray *scarray;

+ (id) spriteWithShape:(cpShape *)shape difficulty:(int)diff;
- (id) initWithShape:(cpShape*)shape difficulty:(int)diff;

@end
