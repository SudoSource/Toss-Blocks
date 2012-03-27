//
//  TimeTrialMode.m
//  Toss Blocks
//
//  Created by Connor on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeTrialMode.h"
#import "cpCCSpriteTB.h"
#import "TBParticleExplosion.h"

@interface TimeTrialMode (ChipmunkMethods)

- (BOOL) handleCollisionWithWall:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space;
- (BOOL) handleCollisionWithBlock:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space;

@end

// HelloWorld implementation
@implementation TimeTrialMode

+ (id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TimeTrialMode *layer = [TimeTrialMode node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
	if( (self=[super init])) {
		
		difficulty = 1;
		
		self.isTouchEnabled = YES;
		//	self.isAccelerometerEnabled = YES;
		
		CCSprite *background = [CCSprite spriteWithFile:@"Backgroundblue.png"];
		background.anchorPoint = ccp(0,0);
		[self addChild:background z:0];
		
		CCSprite *line = [CCSprite spriteWithFile:@"line.png"];
		line.position = ccp(240,0);
		line.anchorPoint = ccp(0.5,0);
		[self addChild:line z:2];
		
		ol1 = [CCSprite spriteWithFile:@"olstripes.png"];
		ol1.position = ccp(240,0);
		ol1.anchorPoint = ccp(0.5,0);
		ol1.opacity = 100;
		[ol1.texture setAliasTexParameters];
		[self addChild:ol1 z:3];
		
		ol2 = [CCSprite spriteWithFile:@"olstripes.png"];
		ol2.position = ccp(240,320);
		ol2.anchorPoint = ccp(0.5,0);
		ol2.opacity = 100;
		[ol2.texture setAliasTexParameters];
		[self addChild:ol2 z:3];
		
		blocks = [CCLayer node];
		[self addChild:blocks z:1];
		
		//SpaceManager Start!
		
		smgr = [[SpaceManagerCocos2d alloc] init];
		[smgr addWindowContainmentWithFriction:1.0 elasticity:0.5 inset:cpv(0,0)];
		
		smgr.constantDt = 1/55.0f;
		
		currnumber = 1;
		[self addNewBlock];
		
		
		cpCCNode *wall = [cpCCNode nodeWithShape:[smgr addRectAt:ccp(240, 320/2) mass:STATIC_MASS width:1 height:320 rotation:0]];
		[self addChild:wall];
		wall.shape->data = wall;
		wall.shape->e = 0.5;
		wall.shape->collision_type = 2;
		
		[smgr addCollisionCallbackBetweenType:1 
									otherType:2 
									   target:self 
									 selector:@selector(handleCollisionWithWall:arbiter:space:)];		
		
		[smgr addCollisionCallbackBetweenType:1 
									otherType:1
									   target:self 
									 selector:@selector(handleCollisionWithBlock:arbiter:space:)];		
		
		
		
		[self schedule:@selector(step:)];
	}
	
	return self;
}

- (BOOL) handleCollisionWithWall:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space
{
	CP_ARBITER_GET_SHAPES(arb, a, b);
	cpCCSpriteTB *block = (cpCCSpriteTB *)a->data;
	if (dragging == NO && block.position.x < 240) {
		for (cpCCSpriteTB *bl in blocks.children) {
			float dist = ccpDistance(block.position, bl.position);
			if (dist < 70 && dist != 0 && bl.blockActive == YES) {
				return YES;
			}
		}
		[block applyImpulse:cpvmult(cpv(50, 1), 100)];
		return NO;
	}else {
		return YES;
	}
}

- (BOOL) handleCollisionWithBlock:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space
{
	CP_ARBITER_GET_SHAPES(arb, a, b);
	cpCCSpriteTB *c = (cpCCSpriteTB *)a->data;
	cpCCSpriteTB *d = (cpCCSpriteTB *)b->data;
	if (moment == COLLISION_BEGIN && c.type == d.type) {
		c.samecolor += 1;
		d.samecolor += 1;
		[c.scarray addObject:[NSNumber numberWithInt:d.number]];
		[d.scarray addObject:[NSNumber numberWithInt:c.number]];
		//NSLog(@"samecolor %d %d", c.samecolor, d.samecolor);
		
		if (c.samecolor > 1 && c != nil) {
			for (cpCCSpriteTB *bl in blocks.children) {
				for (NSNumber *i in c.scarray) {
					int num = [i intValue];
					if (num == bl.number && bl.shape != nil && bl != nil) {
						if (bl.type == 1) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Blue"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 2) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Red"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 3) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Green"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 4) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Purple"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 5) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"White"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 6) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Grey"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 7) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Yellow"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}
						[smgr removeAndFreeShape:bl.shape];
						bl.shape = nil;
						bl.blockActive = NO;
						bl.visible = NO;
					}
				}
			}
			if (c.shape != nil && c != nil) {
				if (c.type == 1) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Blue"];
					explosion.position = c.position;
					[self addChild:explosion z:3];
				}else if (c.type == 2) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Red"];
					explosion.position = c.position;
					[self addChild:explosion z:3];
				}else if (c.type == 3) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Green"];
					explosion.position = c.position;
					[self addChild:explosion z:3];
				}else if (c.type == 4) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Purple"];
					explosion.position = c.position;
					[self addChild:explosion z:3];
				}else if (c.type == 5) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"White"];
					explosion.position = c.position;
					[self addChild:explosion z:3];
				}else if (c.type == 6) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Grey"];
					explosion.position =  c.position;
					[self addChild:explosion z:3];
				}else if (c.type == 7) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Yellow"];
					explosion.position = c.position;
					[self addChild:explosion z:3];
				}	
				[smgr removeAndFreeShape:c.shape];
				c.shape = nil;
				c.blockActive = NO;
				c.visible = NO;
			}
		}
		
		if (d.samecolor > 1 && d != nil) {
			for (cpCCSpriteTB *bl in blocks.children) {
				for (NSNumber *i in d.scarray) {
					int num = [i intValue];
					if (num == bl.number && bl.shape != nil && bl != nil) {
						if (bl.type == 1) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Blue"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 2) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Red"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 3) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Green"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 4) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Purple"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 5) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"White"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 6) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Grey"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}else if (bl.type == 7) {
							TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Yellow"];
							explosion.position = bl.position;
							[self addChild:explosion z:3];
						}	
						[smgr removeAndFreeShape:bl.shape];
						bl.shape = nil;
						bl.blockActive = NO;
						bl.visible = NO;
					}
				}
			}
			if (d.shape != nil && d != nil) {
				if (d.type == 1) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Blue"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}else if (d.type == 2) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Red"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}else if (d.type == 3) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Green"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}else if (d.type == 4) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Purple"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}else if (d.type == 5) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"White"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}else if (d.type == 6) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Grey"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}else if (d.type == 7) {
					TBParticleExplosion *explosion = [TBParticleExplosion explosionWithColor:@"Yellow"];
					explosion.position = d.position;
					[self addChild:explosion z:3];
				}				
				
				[smgr removeAndFreeShape:d.shape];
				d.shape = nil;
				d.blockActive = NO;
				d.visible = NO;
			}
		}
	}
	if (moment == COLLISION_SEPARATE && c.type == d.type) {
		//NSLog(@"samecolor sep");
		if (c != nil) {
			c.samecolor -= 1;
			[c.scarray removeObject:[NSNumber numberWithInt:d.number]];
		}
		if (d != nil) {
			d.samecolor -= 1;
			[d.scarray removeObject:[NSNumber numberWithInt:c.number]];
		}
	}
	return YES;
}

- (void) addNewBlock {
	cpCCSpriteTB *block = [cpCCSpriteTB spriteWithShape:[smgr addRectAt:ccp(50, 320-25) mass:50 width:50 * 0.75 height:50 * 0.75 rotation:0] difficulty:difficulty];
	block.anchorPoint = ccp(0.5,0.5);
	block.scale = 0.75;
	block.shape->collision_type = 1;
	block.shape->data = block;
	block.shape->u = 1.0;
	block.shape->e = 0.5;
	block.mainblock = YES;
	block.number = currnumber;
	[blocks addChild:block];
	currnumber += 1;
}

- (void) step: (ccTime) delta
{
	for (cpCCSpriteTB *block in blocks.children) {
		if (block.mainblock == NO && block.position.x < 250 && block != nil) {
			[block applyImpulse:cpvmult(cpv(50, 1), 100)];
		}
		if (block.mainblock == YES && block != nil) {
			cbp = block.position;
		}if (block.position.x > 240 && block != nil) {
			if (block.mainblock == YES) {
				block.mainblock = NO;
				[self addNewBlock];
			}
		}
	}
	ol1.position = ccp(240,ol1.position.y-delta*50);
	ol2.position = ccp(240,ol2.position.y-delta*50);
	if (ol1.position.y <= -320) {
		ol1.position = ccp(240,320);
		ol2.position = ccp(240,0);
	}
	if (ol2.position.y <= -320) {
		ol2.position = ccp(240,320);
		ol1.position = ccp(240,0);
	}
	[smgr step:delta];
	
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	mouse = cpMouseNew(smgr.space);
	for(UITouch *touch in touches) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		cpMouseMove(mouse, cpv(location.x, location.y));
		if (location.x < 227.5) {
			cpMouseGrab(mouse, cpv(location.x, location.y), YES);
		}
	}
}

- (void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event{
	UITouch *myTouch =  [touches anyObject];
	CGPoint location = [myTouch locationInView: [myTouch view]];
	location = [[CCDirector sharedDirector] convertToGL: location];
	
    //move the nouse to the click
	
	cpMouseMove(mouse, cpv(location.x, location.y));
	dragging = YES;
	if(mouse->body == nil && location.x < 227.5){
		dragging = NO;
		cpMouseGrab(mouse, cpv(location.x, location.y), 0);
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	dragging = NO;
	for(UITouch *touch in touches) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		cpMouseDestroy(mouse);
	}
}



- (void) dealloc
{
	[smgr release];
	[super dealloc];
}

@end

