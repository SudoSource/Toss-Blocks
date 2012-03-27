//
//  TBParticleExplosion.m
//  Toss Blocks
//
//  Created by Connor on 1/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TBParticleExplosion.h"


@implementation TBParticleExplosion

+ (id) explosionWithColor:(NSString *)c{
	return [[[self alloc] initExplosionWithColor:c] autorelease];
}

- (id) initExplosionWithColor:(NSString*)c{
	if ((self = [super init])) {
		self.speed = 100;
		self.speedVar = 32.89;
		self.gravity = ccp(0,0);
		self.radialAccel = -565.79;
		self.radialAccelVar = -1.000;
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
		
		self.life = 0.592;
		self.lifeVar = 0.329;
		self.startSize = 45;
		self.startSizeVar = 20;
		self.endSize = 5;
		self.endSizeVar = 0;
		self.angle = 360;
		self.angleVar = 360;
		
		//self.blendFunc = YES;
		self.blendAdditive = YES;
		
		startColor.r = 0.5f;
		startColor.g = 0.5f;
		startColor.b = 0.5f;
		startColor.a = 0.1f;
		startColorVar.r = 0;
		startColorVar.g = 0;
		startColorVar.b = 0;
		startColorVar.a = 0;
		endColor.r = 0.5f;
		endColor.g = 0.5f;
		endColor.b = 0.5f;
		endColor.a = 0.0f;
		endColorVar.r = 0;
		endColorVar.g = 0;
		endColorVar.b = 0;
		endColorVar.a = 0;
		
		
		duration = 0.14;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: [NSString stringWithFormat:@"%@block.png", c]];
	}
	return self;
}

@end
