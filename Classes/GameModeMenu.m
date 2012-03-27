//
//  GameModeMenu.m
//  Toss Blocks
//
//  Created by jeff on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameModeMenu.h"
#import "FreePlayMode.h"
#import "TimeTrialMode.h"
#import "ArcadeMode.h"
#import "ClassicMode.h"
#import "MainMenu.h"

@implementation GameModeMenu

+ (id) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    GameModeMenu *layer = [GameModeMenu node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (id) init {
    if ((self = [super init])) {
        CCSprite *background = [CCSprite spriteWithFile:@"Submenu-background.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background z:1];
        
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(mainMenu)];
        CCMenu *backMenu = [CCMenu menuWithItems:back, nil];
        back.anchorPoint = ccp(1,0);
        back.position = ccp(480,0);
        backMenu.position = ccp(0,0);
        [self addChild:backMenu z:4];
        
        
        classicIcon = [CCSprite spriteWithFile:@"Redblock.png"];
        classicIcon.position = ccp(80,282);
        classicIcon.rotation = 35;
        classicIcon.scale = 0.6;
        [self addChild:classicIcon z:3];
        
        freeplayIcon = [CCSprite spriteWithFile:@"Greenblock.png"];
        freeplayIcon.position = ccp(80,226);
        freeplayIcon.rotation = -30;
        freeplayIcon.scale = 0.6;
        [self addChild:freeplayIcon z:3];
        
        
        timetrialIcon = [CCSprite spriteWithFile:@"Purpleblock.png"];
        timetrialIcon.position = ccp(80,170);
        timetrialIcon.rotation = 20;
        timetrialIcon.scale = 0.6;
        [self addChild:timetrialIcon z:3];
        
        arcadeIcon = [CCSprite spriteWithFile:@"Whiteblock.png"];
        arcadeIcon.position = ccp(80,114);
        arcadeIcon.rotation = 45;
        arcadeIcon.scale = 0.6;
        [self addChild:arcadeIcon z:3];
        
        onlineIcon = [CCSprite spriteWithFile:@"Greyblock.png"];
        onlineIcon.position = ccp(80,58);
        onlineIcon.rotation = -10;
        onlineIcon.scale = 0.6;
        [self addChild:onlineIcon z:3];
        
        CCLabelBMFont *classicLabel = [CCLabelBMFont labelWithString:@"Play Classic Mode" fntFile:@"MenuFont.fnt"];
        CCMenuItemLabel *classic = [CCMenuItemLabel itemWithLabel:classicLabel target:self selector:@selector(playClassic)];
        classic.anchorPoint = ccp(0,0);
        
        CCLabelBMFont *freeplayLabel = [CCLabelBMFont labelWithString:@"Play Free Play Mode" fntFile:@"MenuFont.fnt"];
        CCMenuItemLabel *freeplay = [CCMenuItemLabel itemWithLabel:freeplayLabel target:self selector:@selector(playFreeplay)];
        freeplay.anchorPoint = ccp(0,0);
        
        CCLabelBMFont *timetrialLabel = [CCLabelBMFont labelWithString:@"Play Time Trial Mode" fntFile:@"MenuFont.fnt"];
        CCMenuItemLabel *timetrial = [CCMenuItemLabel itemWithLabel:timetrialLabel target:self selector:@selector(playTimetrial)];
        timetrial.anchorPoint = ccp(0,0);

        CCLabelBMFont *arcadeLabel = [CCLabelBMFont labelWithString:@"Play Arcade Mode" fntFile:@"MenuFont.fnt"];
        CCMenuItemLabel *arcade = [CCMenuItemLabel itemWithLabel:arcadeLabel target:self selector:@selector(playArcade)];
        arcade.anchorPoint = ccp(0,0);
        
        CCLabelBMFont *onlineLabel = [CCLabelBMFont labelWithString:@"Play Online" fntFile:@"MenuFont.fnt"];
        CCMenuItemLabel *online = [CCMenuItemLabel itemWithLabel:onlineLabel target:self selector:@selector(playOnline)];
        online.anchorPoint = ccp(0,0);
        
        menu = [CCMenu menuWithItems:classic, freeplay, timetrial, arcade, online, nil];
        [menu alignItemsVerticallyWithPadding:20];
        
        [self addChild:menu z:3];
        menu.position = ccp(100,150);
        
        stripes = [CCLayer new];
        [self addChild:stripes z:2];
        
        stripes1 = [CCSprite spriteWithFile:@"submenustripes.png"];
        stripes1.position = ccp(240,0);
        stripes1.anchorPoint = ccp(0,0);
        stripes1.opacity = 25;
        [stripes1.texture setAliasTexParameters];
        [stripes addChild:stripes1 z:2];
        
        stripes2 = [CCSprite spriteWithFile:@"submenustripes.png"];
        stripes2.position = ccp(240,320);
        stripes2.anchorPoint = ccp(0,0);
        stripes2.opacity = 25;
        [stripes2.texture setAliasTexParameters];
        [stripes addChild:stripes2 z:2];
        
        stripes3 = [CCSprite spriteWithFile:@"submenustripes.png"];
        stripes3.position = ccp(0,0);
        stripes3.scaleX = -1;
        stripes3.anchorPoint = ccp(1,0);
        stripes3.opacity = 25;
        [stripes3.texture setAliasTexParameters];
        [stripes addChild:stripes3 z:2];
        
        stripes4 = [CCSprite spriteWithFile:@"submenustripes.png"];
        stripes4.position = ccp(0,-320);
        stripes4.scaleX = -1;
        stripes4.anchorPoint = ccp(1,0);
        stripes4.opacity = 25;
        [stripes4.texture setAliasTexParameters];
        [stripes addChild:stripes4 z:2];
        
        [self schedule:@selector(step:)];
    }
    return self;
}

- (void) step: (ccTime) delta
{
    stripes1.position = ccp(240,stripes1.position.y-delta*25);
    stripes2.position = ccp(240,stripes2.position.y-delta*25);
    if (stripes1.position.y <= -320) {
        stripes1.position = ccp(240,320);
        stripes2.position = ccp(240,0);
    }
    if (stripes2.position.y <= -320) {
        stripes2.position = ccp(240,320);
        stripes1.position = ccp(240,0);
    }
    
    stripes3.position = ccp(0,stripes3.position.y-delta*25);
    stripes4.position = ccp(0,stripes4.position.y-delta*25);
    if (stripes3.position.y <= -320) {
        stripes3.position = ccp(0,320);
        stripes4.position = ccp(0,0);
    }
    if (stripes4.position.y <= -320) {
        stripes4.position = ccp(0,320);
        stripes3.position = ccp(0,0);
    }
}

- (void) mainMenu {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5f scene:[MainMenu scene]]];
}

- (void) playClassic {
    menu.isTouchEnabled = NO;
    [classicIcon runAction:[CCSequence actions:[CCRotateTo actionWithDuration:0.2f angle:0], [CCCallFuncN actionWithTarget:self selector:@selector(classicSwitch)], nil]];
}

- (void) classicSwitch {
    CCLayerColor *white = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:480 height:360];
    [self addChild:white z:4];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[ClassicMode scene] withColor:ccc3(255, 255, 255)]]; 
}

- (void) playFreeplay {
    menu.isTouchEnabled = NO;
    [freeplayIcon runAction:[CCSequence actions:[CCRotateTo actionWithDuration:0.2f angle:0],[CCCallFuncN actionWithTarget:self selector:@selector(freeplaySwitch)], nil]];
}

- (void) freeplaySwitch {
    CCLayerColor *white = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:480 height:360];
    [self addChild:white z:4];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[FreePlayMode scene] withColor:ccc3(255, 255, 255)]]; 
}

- (void) playTimetrial {
    menu.isTouchEnabled = NO;
    [timetrialIcon runAction:[CCSequence actions:[CCRotateTo actionWithDuration:0.2f angle:0],[CCCallFuncN actionWithTarget:self selector:@selector(timetrialSwitch)], nil]];
}

- (void) timetrialSwitch {
    CCLayerColor *white = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:480 height:360];
    [self addChild:white z:4];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[TimeTrialMode scene] withColor:ccc3(255, 255, 255)]]; 
}

- (void) playArcade {
    menu.isTouchEnabled = NO;
    [arcadeIcon runAction:[CCSequence actions:[CCRotateTo actionWithDuration:0.2f angle:0], [CCCallFuncN actionWithTarget:self selector:@selector(arcadeSwitch)], nil]];
}

- (void) arcadeSwitch {
    CCLayerColor *white = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:480 height:360];
    [self addChild:white z:4];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[ArcadeMode scene] withColor:ccc3(255, 255, 255)]]; 
}

- (void) playOnline {
    //menu.isTouchEnabled = NO;
    [onlineIcon runAction:[CCSequence actions:[CCRotateTo actionWithDuration:0.2f angle:0], [CCCallFuncN actionWithTarget:self selector:@selector(onlineSwitch)], nil]];
}

- (void) onlineSwitch {
    //CCLayerColor *white = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:480 height:360];
    //[self addChild:white z:4];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[FreePlayMode scene] withColor:ccc3(255, 255, 255)]]; 
}

@end
