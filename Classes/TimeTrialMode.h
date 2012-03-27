//
//  TimeTrialMode.h
//  Toss Blocks
//
//  Created by Connor on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceManagerCocos2d.h"
#import "cpMouse.h"

@interface TimeTrialMode : CCLayer {
	cpMouse *mouse;
	CCSprite *ol1, *ol2;
	SpaceManagerCocos2d *smgr;
	CCLayer *blocks;
	BOOL dragging;
	CGPoint cbp;
	int currnumber;
	int difficulty;	
}

+ (id) scene;
- (void) step: (ccTime) dt;
- (void) addNewBlock;

@end
