//
//  FreePlayMode.h
//  Toss Blocks
//
//  Created by Connor on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceManagerCocos2d.h"
#import "cpMouse.h"

@interface FreePlayMode : CCLayer {
	cpMouse *mouse;
	CCSprite *ol1, *ol2;
    CCSprite *glasstop, *glassbottom;
	SpaceManagerCocos2d *smgr;
	CCLayer *blocks;
	BOOL dragging, released;
	CGPoint cbp;
	int currnumber;
	int difficulty;
    float highpoint;
    CCLabelBMFont *scoreLabel;
	float score;
}

+ (id) scene;
- (void) step: (ccTime) dt;
- (void) addNewBlock;

@end
