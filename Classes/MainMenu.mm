//
//  MainMenu.m
//  Toss Blocks
//
//  Created by Connor on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "cpCCSpriteTB.h"
#import "GameModeMenu.h"
#import "OptionsMenu.h"

@implementation MainMenu

+ (id) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    MainMenu *layer = [MainMenu node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (id) init {
    if ((self = [super init])) {
        //Enables
        self.isAccelerometerEnabled = YES;
        
        mainLayer = [CCLayer new];
        [self addChild:mainLayer z:4];
        
        blocks = [CCLayer new];
        [self addChild:blocks z:2];
        
        //Background
        CCSprite *background = [CCSprite spriteWithFile:@"menuback.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background z:0];
        
        stripes1 = [CCSprite spriteWithFile:@"menustripes.png"];
        stripes1.position = ccp(330,0);
        stripes1.anchorPoint = ccp(0.5,0);
        stripes1.opacity = 100;
        [stripes1.texture setAliasTexParameters];
        [self addChild:stripes1 z:1];
        
        stripes2 = [CCSprite spriteWithFile:@"menustripes.png"];
        stripes2.position = ccp(330,320);
        stripes2.anchorPoint = ccp(0.5,0);
        stripes2.opacity = 100;
        [stripes2.texture setAliasTexParameters];
        [self addChild:stripes2 z:1];
        
        CCSprite *overlay = [CCSprite spriteWithFile:@"menuoverlay.png"];
        overlay.anchorPoint = ccp(0,0);
        [mainLayer addChild:overlay z:3];
        
        //MENU!!!!
        CCMenuItemImage * play = [CCMenuItemImage itemFromNormalImage:@"menuplay.png" selectedImage:@"menuplay.png" target:self selector:@selector(play:)];
        CCMenuItemImage * options = [CCMenuItemImage itemFromNormalImage:@"menuoptions.png" selectedImage:@"menuoptions.png" target:self selector:@selector(options:)];
        CCMenuItemImage * help = [CCMenuItemImage itemFromNormalImage:@"menuhelp.png" selectedImage:@"menuhelp.png" target:self selector:@selector(play:)];
        CCMenuItemImage * credits = [CCMenuItemImage itemFromNormalImage:@"menucredits.png" selectedImage:@"menucredits.png" target:self selector:@selector(play:)];
        menu = [CCMenu menuWithItems:play, options, help, credits, nil];
        [menu alignItemsVerticallyWithPadding:29];
        
        [mainLayer addChild:menu z:4];
        
        menu.position = ccp(132,172);
        menu.anchorPoint = ccp(0,0);
        
        //SpaceManager
        smgr = [[SpaceManagerCocos2d alloc] init];
        [smgr addWindowContainmentWithFriction:1.0 elasticity:0.25 inset:cpv(0,0)];
        smgr.space->iterations = 1;
        smgr.space->elasticIterations = 0;
        
        
        smgr.constantDt = 1/60.0f;
        
        [smgr addSegmentAt:ccp(0,0) fromLocalAnchor:ccp(240,0) toLocalAnchor:ccp(240,320) mass:STATIC_MASS radius:0];
        
        //Add Blocks!
        [self addNewBlock];
        [self addNewBlock];
        [self addNewBlock];
        [self addNewBlock];
        [self addNewBlock];
        [self addNewBlock];
        
        
        
        
        
        //Schedule
        [self schedule:@selector(step:)];
    }
    return self;
}

-(void)play:(id)sender{
    [smgr stop];
    GameModeMenu *background = [GameModeMenu new];
    background.anchorPoint = ccp(0,0);
    background.position = ccp(-480,0);
    [mainLayer addChild:background];
    [mainLayer runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5f position:ccp(480,0)],[CCCallFuncN actionWithTarget:self selector:@selector(gameModeMenu)], nil]];
}

-(void)options:(id)sender{
    [smgr stop];
    OptionsMenu *background = [OptionsMenu new];
    background.anchorPoint = ccp(0,0);
    background.position = ccp(-480,0);
    [mainLayer addChild:background];
    [mainLayer runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5f position:ccp(480,0)],[CCCallFuncN actionWithTarget:self selector:@selector(optionsModeMenu)], nil]];
}

- (void)gameModeMenu {
    [[CCDirector sharedDirector] replaceScene:[GameModeMenu scene]];
}

- (void)optionsModeMenu {
    [[CCDirector sharedDirector] replaceScene:[OptionsMenu scene]];
}

- (void) addNewBlock {
    float ranx = 300 + arc4random() % 120;
    float rany = 100 + arc4random() % 200;
    NSLog(@"%f %f", ranx, rany);
    cpCCSpriteTB *block = [cpCCSpriteTB spriteWithShape:[smgr addRectAt:ccp(50, 320-25) mass:50 width:50 * 0.75 height:50 * 0.75 rotation:0] difficulty:5];
    block.anchorPoint = ccp(0.5,0.5);
    block.position = ccp(ranx, rany);
    block.scale = 0.75;
    block.shape->collision_type = 1;
    block.shape->data = block;
    block.shape->u = 1.0;
    block.shape->e = 0.5;
    block.mainblock = YES;
    [blocks addChild:block];
    
}

- (void) onEnter
{
    [super onEnter];
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
    static float prevX=0, prevY=0;
    
#define kFilterFactor 0.05f
    
    float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
    float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
    
    prevX = accelX;
    prevY = accelY;
    
    if ([[CCDirector sharedDirector] lr] == NO) {
        CGPoint v = ccp( accelY, -accelX);
        
        smgr.gravity = ccpMult(v, 200);
    }else if ([[CCDirector sharedDirector] lr] == YES) {
        CGPoint v = ccp( -accelY, accelX);
        
        smgr.gravity = ccpMult(v, 200);
    }
    
}

- (void) step: (ccTime) delta
{
    stripes1.position = ccp(330,stripes1.position.y-delta*50);
    stripes2.position = ccp(330,stripes2.position.y-delta*50);
    if (stripes1.position.y <= -320) {
        stripes1.position = ccp(330,320);
        stripes2.position = ccp(330,0);
    }
    if (stripes2.position.y <= -320) {
        stripes2.position = ccp(330,320);
        stripes1.position = ccp(330,0);
    }
    
    [smgr step:delta];
}

- (void) dealloc {
    [smgr release];
    [super dealloc];
}

@end
