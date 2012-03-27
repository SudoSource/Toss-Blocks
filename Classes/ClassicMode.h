//
//  HelloWorldScene.m
//  Toss Blocks
//
//  Created by Connor on 1/19/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"
#import "SpaceManagerCocos2d.h"
#import "cpMouse.h"

@interface ClassicMode : CCLayer
{
	cpMouse *mouse;
	CCSprite *ol1, *ol2;
	SpaceManagerCocos2d *smgr;
	CCLabelBMFont *scoreLabel;
	CCLayer *blocks;
	BOOL dragging;
	CGPoint cbp;
	int currnumber;
	int difficulty;
	float score;
}

// returns a Scene that contains the HelloWorld as the only child
+ (id) scene;
- (void) step: (ccTime) dt;
- (void) addNewBlock;

@end
