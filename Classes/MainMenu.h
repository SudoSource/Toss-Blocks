//
//  MainMenu.h
//  Toss Blocks
//
//  Created by Connor on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpaceManagerCocos2d.h"
#import "cocos2d.h"

@interface MainMenu : CCLayer {
	CCSprite *stripes1, *stripes2;
    CCLayer *mainLayer, *blocks;
    CCMenu *menu;
	SpaceManagerCocos2d *smgr;
}

+ (id) scene;
- (void) addNewBlock;

@end
