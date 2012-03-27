//
//  OptionsMenu.m
//  Toss Blocks
//
//  Created by jeff on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionsMenu.h"
#import "MainMenu.h"

@implementation OptionsMenu

+ (id) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    OptionsMenu *layer = [OptionsMenu node];
    
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
        
        CCLabelBMFont *options = [CCLabelBMFont labelWithString:@"Options" fntFile:@"MenuFont.fnt"];
        [self addChild:options z:3];
        options.anchorPoint = ccp(0.5, 0);
        options.position = ccp(240, 270);
        
        CCLabelBMFont *sound = [CCLabelBMFont labelWithString:@"FX Volume" fntFile:@"MenuFont.fnt"];
        [self addChild:sound z:3];
        sound.anchorPoint = ccp(0.5, 0);
        sound.position = ccp(240, 200);
        sound.scale = .75;
        
        GPSlider *soundvol = [GPSlider sliderWithRail:@"slider.png" knob:@"knob.png"];
        soundvol.knobsel = @"knob-down.png";
        [self addChild:soundvol z:3];
        soundvol.position = ccp(240, 190);
        
        CCLabelBMFont *music = [CCLabelBMFont labelWithString:@"Music Volume" fntFile:@"MenuFont.fnt"];
        [self addChild:music z:3];
        music.anchorPoint = ccp(0.5, 0);
        music.position = ccp(240, 110);
        music.scale = .75;
        
        GPSlider *musicvol = [GPSlider sliderWithRail:@"slider.png" knob:@"knob.png"];
        musicvol.knobsel = @"knob-down.png";
        [self addChild:musicvol z:3];
        musicvol.position = ccp(240, 100);
        
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(mainMenu)];
        CCMenu *backMenu = [CCMenu menuWithItems:back, nil];
        back.anchorPoint = ccp(1,0);
        back.position = ccp(480,0);
        backMenu.position = ccp(0,0);
        [self addChild:backMenu z:4];
        
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

- (void) mainMenu {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5f scene:[MainMenu scene]]];
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

@end

