//
//  GameModeMenu.h
//  Toss Blocks
//
//  Created by jeff on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameModeMenu : CCLayer {
    CCSprite *stripes1, *stripes2, *stripes3, *stripes4;
    CCLayer *stripes;
    CCSprite *classicIcon;
    CCSprite *freeplayIcon;
    CCSprite *timetrialIcon;
    CCSprite *arcadeIcon;
    CCSprite *onlineIcon;
    CCMenu *menu;
}

+ (id) scene;

@end
