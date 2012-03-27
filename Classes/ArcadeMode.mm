//
//  ArcadeMode.m
//  Toss Blocks
//
//  Created by Connor on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArcadeMode.h"


@implementation ArcadeMode

+ (id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ArcadeMode *layer = [ArcadeMode node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

@end
